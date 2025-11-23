#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int iabs(int x) {
    return x < 0 ? -x : x;
}

int findValueOfPartition(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int minDiff = INT_MAX;
    for (int i = 1; i < numsSize; i++) {
        minDiff = iabs(nums[i] - nums[i-1]) < minDiff ? iabs(nums[i] - nums[i-1]) : minDiff;
    }
    return minDiff;
}