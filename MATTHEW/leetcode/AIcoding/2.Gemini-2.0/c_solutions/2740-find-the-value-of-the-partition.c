#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findValueOfPartition(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int minDiff = abs(nums[1] - nums[0]);
    for (int i = 2; i < numsSize; i++) {
        int diff = abs(nums[i] - nums[i - 1]);
        if (diff < minDiff) {
            minDiff = diff;
        }
    }
    return minDiff;
}