#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int cost = 0;
    for (int i = 0; i < numsSize / 2; i++) {
        cost += nums[numsSize - 1 - i] - nums[i];
    }

    return cost;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}