//
//  ViewController.m
//  demoSwift
//
//  Created by Sarang Jiwane on 22/12/16.
//  Copyright © 2016 iOSDev. All rights reserved.
//

#import "ViewController.h"
#import "FHSTwitterEngine.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface ViewController () <FHSTwitterEngineAccessTokenDelegate, UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(twitterButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Twitter" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];

    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self
               action:@selector(facebookButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"Facebook" forState:UIControlStateNormal];
    button2.frame = CGRectMake(80.0, 310.0, 160.0, 40.0);
    [self.view addSubview:button2];

    
    
    
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"wCz87HhvAYibzMSrTnnPU06g5" andSecret:@"MS7K2jc8L0qymzi85gJShxgEPe8cgckHBvqCkQay9xn0tfe6HQ"];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)storeAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"SavedAccessHTTPBody"];
}

- (NSString *)loadAccessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"SavedAccessHTTPBody"];
}

-(void)twitterButtonPressed
{
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
        NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
    }];
    [self presentViewController:loginController animated:YES completion:nil];

}
-(void)facebookButtonPressed
{
    
    
    
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error)
        {
            // Process error
            NSLog(@"error");
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[error localizedDescription]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            
        }
        else if (result.isCancelled)
        {
            
            NSLog(@"cancelled");
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Operation cancelled by User" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            
            // Handle cancellations
        }
        
        else
        {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"])
            {
                NSLog(@"request Granted");
                
                
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     
                     if (!error)
                     {
                         
                         NSLog(@"%@", result);
                         
                         
                         NSLog(@"successfully login");
                         
                         
                         
                         
                         
                         
                     }
                     else
                     {
                         
                         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[error localizedDescription]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alert show];
                         
                         
                     }
                 }];
                
            }
        }
        
    }];
    
    
    
    
    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
