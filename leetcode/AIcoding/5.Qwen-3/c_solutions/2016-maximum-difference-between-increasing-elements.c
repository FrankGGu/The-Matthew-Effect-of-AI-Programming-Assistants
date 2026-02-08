#include <stdio.h>
#include <stdlib.h>

int maximumDifference(int* nums, int numsSize) {
    int minVal = nums[0];
    int maxDiff = -1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > minVal) {
            maxDiff = fmax(maxDiff, nums[i] - minVal);
        } else {
            minVal = nums[i];
        }
    }

    return maxDiff;
}