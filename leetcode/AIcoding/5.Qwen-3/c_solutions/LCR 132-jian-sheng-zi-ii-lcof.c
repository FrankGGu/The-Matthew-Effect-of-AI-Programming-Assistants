#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCost(int* nums, int numsSize) {
    if (numsSize <= 1) return 0;
    qsort(nums, numsSize, sizeof(int), cmp);
    int cost = 0;
    for (int i = numsSize - 1; i > 0; i--) {
        cost += nums[i] - nums[i - 1];
    }
    return cost;
}