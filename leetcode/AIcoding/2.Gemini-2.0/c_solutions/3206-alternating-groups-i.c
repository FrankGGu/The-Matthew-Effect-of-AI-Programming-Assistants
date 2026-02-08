#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int alternatingSubarray(int* nums, int numsSize){
    int maxLen = -1;
    for(int i = 0; i < numsSize - 1; i++){
        for(int j = i + 1; j < numsSize; j++){
            int len = j - i + 1;
            int valid = 1;
            for(int k = i; k < j; k++){
                if(nums[k+1] - nums[k] != (k - i) % 2 == 0 ? 1 : -1){
                    valid = 0;
                    break;
                }
            }
            if(valid){
                if(len > maxLen){
                    maxLen = len;
                }
            }
        }
    }
    return maxLen;
}