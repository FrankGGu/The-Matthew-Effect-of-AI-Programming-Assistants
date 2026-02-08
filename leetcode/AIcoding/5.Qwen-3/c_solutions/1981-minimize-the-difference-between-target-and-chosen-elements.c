#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMinDifference(int* nums, int numsSize, int target) {
    qsort(nums, numsSize, sizeof(int), compare);

    int minDiff = INT_MAX;
    for (int i = 0; i < numsSize; i++) {
        int diff = abs(nums[i] - target);
        if (diff < minDiff) {
            minDiff = diff;
        }
    }
    return minDiff;
}