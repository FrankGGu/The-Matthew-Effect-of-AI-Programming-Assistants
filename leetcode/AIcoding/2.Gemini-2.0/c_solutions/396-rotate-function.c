#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxRotateFunction(int* nums, int numsSize){
    int sum = 0;
    int f = 0;
    for(int i = 0; i < numsSize; i++){
        sum += nums[i];
        f += i * nums[i];
    }
    int max = f;
    for(int i = 1; i < numsSize; i++){
        f = f + sum - numsSize * nums[numsSize - i];
        if(f > max){
            max = f;
        }
    }
    return max;
}