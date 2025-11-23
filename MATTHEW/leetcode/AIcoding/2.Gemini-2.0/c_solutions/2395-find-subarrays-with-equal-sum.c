#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool findSubarrays(int* nums, int numsSize){
    if (numsSize <= 1) return false;

    int sums[numsSize - 1];
    for (int i = 0; i < numsSize - 1; i++) {
        sums[i] = nums[i] + nums[i+1];
    }

    for (int i = 0; i < numsSize - 2; i++) {
        for (int j = i + 1; j < numsSize - 1; j++) {
            if (sums[i] == sums[j]) return true;
        }
    }

    return false;
}