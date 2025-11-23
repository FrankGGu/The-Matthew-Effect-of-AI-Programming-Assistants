#include <stdio.h>
#include <stdlib.h>

int maxAfterMerge(int* nums, int numsSize) {
    int maxVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        } else {
            nums[i] += nums[i - 1];
            if (nums[i] > maxVal) {
                maxVal = nums[i];
            }
        }
    }
    return maxVal;
}