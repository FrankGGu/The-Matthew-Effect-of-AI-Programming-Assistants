#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool zeroFilledSubarray(int* nums, int numsSize){
    long long count = 0;
    long long ans = 0;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] == 0){
            count++;
            ans += count;
        } else {
            count = 0;
        }
    }

    return ans;
}