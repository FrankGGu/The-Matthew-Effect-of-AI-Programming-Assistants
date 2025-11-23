#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minArraySum(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    long long currentSum = nums[0];
    int expectedNext = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= expectedNext) {
            expectedNext++;
            currentSum += expectedNext;
        } else {
            expectedNext = nums[i];
            currentSum += nums[i];
        }
    }

    return currentSum;
}