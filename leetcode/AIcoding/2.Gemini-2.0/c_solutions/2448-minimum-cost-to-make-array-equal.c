#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minCost(int* nums, int numsSize, int* cost, int costSize) {
    int minVal = nums[0];
    int maxVal = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    long long minCostVal = -1;
    for (int target = minVal; target <= maxVal; target++) {
        long long currentCost = 0;
        for (int i = 0; i < numsSize; i++) {
            currentCost += (long long)abs(nums[i] - target) * cost[i];
        }

        if (minCostVal == -1 || currentCost < minCostVal) {
            minCostVal = currentCost;
        }
    }

    return minCostVal;
}