#include <stdio.h>
#include <stdlib.h>

long long minCostToMakeEqual(int* nums, int numsSize, int* cost, int costSize) {
    int* sortedIndices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sortedIndices[i] = i;
    }

    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (nums[sortedIndices[j]] > nums[sortedIndices[j + 1]]) {
                int temp = sortedIndices[j];
                sortedIndices[j] = sortedIndices[j + 1];
                sortedIndices[j + 1] = temp;
            }
        }
    }

    long long totalCost = 0;
    for (int i = 0; i < numsSize; i++) {
        totalCost += (long long)abs(nums[sortedIndices[i]] - nums[sortedIndices[numsSize / 2]]) * cost[sortedIndices[i]];
    }

    free(sortedIndices);
    return totalCost;
}