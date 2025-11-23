#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

void dfs(int* baseCosts, int baseCostsSize, int* topings, int topingsSize, int currentCost, int target, int* closest) {
    if (currentCost > target + abs(*closest - target)) {
        return;
    }
    if (abs(currentCost - target) < abs(*closest - target)) {
        *closest = currentCost;
    } else if (abs(currentCost - target) == abs(*closest - target) && currentCost < *closest) {
        *closest = currentCost;
    }
    for (int i = 0; i < topingsSize; i++) {
        dfs(baseCosts, baseCostsSize, topings, topingsSize, currentCost + topings[i], target, closest);
    }
}

int closestCost(int* baseCosts, int baseCostsSize, int* topings, int topingsSize, int target, int* retVal) {
    int closest = INT_MAX;
    for (int i = 0; i < baseCostsSize; i++) {
        dfs(baseCosts, baseCostsSize, topings, topingsSize, baseCosts[i], target, &closest);
    }
    *retVal = closest;
    return closest;
}