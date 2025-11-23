#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int smallestRangeII(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int minRange = nums[numsSize - 1] - nums[0];
    for (int i = 0; i < numsSize - 1; i++) {
        int a = nums[i];
        int b = nums[i + 1];
        int newMin = fmin(a, nums[numsSize - 1]);
        int newMax = fmax(b, nums[0]);
        minRange = fmin(minRange, newMax - newMin);
    }
    return minRange;
}