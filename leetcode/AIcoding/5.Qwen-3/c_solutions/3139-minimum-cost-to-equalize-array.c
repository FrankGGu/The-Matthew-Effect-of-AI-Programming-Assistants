#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minCostToEqualize(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    long long cost = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        cost += (long long)(nums[i + 1] - nums[i]) * (i + 1);
    }
    return cost;
}