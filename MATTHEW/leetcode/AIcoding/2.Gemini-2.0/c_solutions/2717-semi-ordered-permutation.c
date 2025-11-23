#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int semiOrderedPermutation(int* nums, int numsSize){
    int first = -1, last = -1;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] == 1){
            first = i;
        }
        if(nums[i] == numsSize){
            last = i;
        }
    }

    if(first > last){
        return first + (numsSize - 1 - last) - 1;
    }

    return first + (numsSize - 1 - last);
}