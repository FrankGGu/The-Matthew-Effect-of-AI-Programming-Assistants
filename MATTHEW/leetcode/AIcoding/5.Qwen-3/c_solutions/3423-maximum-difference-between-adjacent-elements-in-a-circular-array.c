#include <stdio.h>
#include <stdlib.h>

int maxDiffCircular(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int minVal = nums[0], maxVal = nums[0];
    int minIdx = 0, maxIdx = 0;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
            minIdx = i;
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
            maxIdx = i;
        }
    }

    int diff1 = maxVal - minVal;
    int diff2 = (nums[0] - nums[minIdx]) + (nums[maxIdx] - nums[numsSize - 1]);

    return (diff1 > diff2) ? diff1 : diff2;
}