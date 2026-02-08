#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int repeatedNTimes(int* nums, int numsSize){
    int count[10000] = {0};
    for(int i = 0; i < numsSize; i++){
        count[nums[i]]++;
        if(count[nums[i]] == numsSize / 2){
            return nums[i];
        }
    }
    return 0;
}