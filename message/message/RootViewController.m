//
//  RootViewController.m
//  message
//
//  Created by David on 13-11-8.
//  Copyright (c) 2013年 David. All rights reserved.
//  MSN:yangbo_hbzjk@163.com
//  qq:327932709

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(200, 100, 80, 70)];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
	// Do any additional setup after loading the view.
}

- (void)buttonClicked:(UIButton *)sender
{
    Class messageClass = NSClassFromString(@"MFMessageComposeViewController");
    
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"没有短信功能" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NULL message:@"ios4.0以上才支持程序内短信功能，版本太低" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc]init];
    picker.messageComposeDelegate = self;
    
    NSMutableString *absUrl = [[NSMutableString alloc]initWithString:@"sdf"];
    
    [absUrl replaceOccurrencesOfString:@"http://i.aizheke.com" withString:@"http://m.aizheke.com" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [absUrl length])];
    
    picker.body = [NSString stringWithFormat:@"这是David's message短信发送"];
    
    [self presentModalViewController:picker animated:YES];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result:SMS sent");
            break;
        case MessageComposeResultFailed:
            NSLog(@"失败");
            break;
        default:
            NSLog(@"Result:SMS not sent");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
