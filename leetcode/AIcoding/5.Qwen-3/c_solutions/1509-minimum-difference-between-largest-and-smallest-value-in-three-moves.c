#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minDifference(int* nums, int numsSize) {
    if (numsSize <= 4) return 0;
    qsort(nums, numsSize, sizeof(int), compare);
    return nums[numsSize-4] - nums[0];
}