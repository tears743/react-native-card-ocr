#import "CardOcr.h"

@implementation CardOcr 

RCT_EXPORT_MODULE()


RCT_REMAP_METHOD(idCardOcr,
                 findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
 
   
    JYBDIDCardVC *AVCaptureVC = [[JYBDIDCardVC alloc] init];
    
    AVCaptureVC.finish = ^(JYBDCardIDInfo *info, UIImage *image)
    {
        // Create path.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
        
        // Save image.
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
//        @property (nonatomic,assign) int type; //1:正面  2:反面
//        @property (nonatomic,copy) NSString *num; //身份证号
//        @property (nonatomic,copy) NSString *name; //姓名
//        @property (nonatomic,copy) NSString *gender; //性别
//        @property (nonatomic,copy) NSString *nation; //民族
//        @property (nonatomic,copy) NSString *address; //地址
//        @property (nonatomic,copy) NSString *issue; //签发机关
//        @property (nonatomic,copy) NSString *valid; //有效期
        resolve(@{
                  @"image":filePath,
                  @"idCard":info.num,
                  @"name":info.name,
                  @"gender":info.gender,
                  @"nation":info.nation,
                  @"address":info.address,
                  @"issue":info.issue,
                  @"valid":info.valid,
                  @"type":info.type==1?@"正面":@"反面"
                  });
    };
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *controller = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [controller presentViewController:AVCaptureVC animated:YES completion:nil];
    });
}

RCT_REMAP_METHOD(bankCardOcr,
                 resolver:(RCTPromiseResolveBlock)resolver
                 rejecter:(RCTPromiseRejectBlock)rejecter)
{

    JYBDBankCardVC *vc = [[JYBDBankCardVC alloc]init];
    vc.finish = ^(JYBDBankCardInfo *info, UIImage *image) {
        // Create path.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
        
        // Save image.
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        resolver(@{
                   @"bankNumber":info.bankNumber,
                   @"bankName":info.bankName,
                   });
        
    };
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *controller = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [controller presentViewController:vc animated:YES completion:nil];
    });
}

@end
