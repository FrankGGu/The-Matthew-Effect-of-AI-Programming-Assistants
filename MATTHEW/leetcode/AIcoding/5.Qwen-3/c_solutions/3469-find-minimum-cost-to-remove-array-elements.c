#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCost(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    qsort(nums, numsSize, sizeof(int), compare);
    int cost = 0;
    int n = numsSize;
    for (int i = 0; i < n; i++) {
        cost += nums[i] * (i + 1);
    }
    return cost;
}