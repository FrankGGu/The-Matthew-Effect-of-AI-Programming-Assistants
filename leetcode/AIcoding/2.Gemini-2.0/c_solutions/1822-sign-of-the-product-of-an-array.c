#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int arraySign(int* nums, int numsSize){
    int negCount = 0;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] == 0){
            return 0;
        }
        if(nums[i] < 0){
            negCount++;
        }
    }
    if(negCount % 2 == 0){
        return 1;
    } else {
        return -1;
    }
}