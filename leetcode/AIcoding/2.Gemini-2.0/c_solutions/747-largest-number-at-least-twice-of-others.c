#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dominantIndex(int* nums, int numsSize){
    int maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (i != maxIndex && nums[i] * 2 > nums[maxIndex]) {
            return -1;
        }
    }

    return maxIndex;
}