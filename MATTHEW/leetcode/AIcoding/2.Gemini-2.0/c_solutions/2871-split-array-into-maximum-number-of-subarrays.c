#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSubarrays(int* nums, int numsSize){
    int result = 0;
    int currentAnd = nums[0];
    for (int i = 1; i < numsSize; i++) {
        currentAnd &= nums[i];
    }

    if (currentAnd != 0) {
        return 1;
    }

    result = 0;
    currentAnd = nums[0];
    for (int i = 1; i < numsSize; i++) {
        currentAnd &= nums[i];
        if (currentAnd == 0) {
            result++;
            if (i + 1 < numsSize){
                currentAnd = nums[i+1];
                i++;
            }
            else
                break;
        }
    }

    return result + 1;
}