#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDiff = INT_MAX;
int closestCost = 0;

void dfs(int cost, int target, int* toppingCosts, int toppingCostsSize, int index) {
    if (index == toppingCostsSize) {
        int diff = abs(cost - target);
        if (diff < minDiff) {
            minDiff = diff;
            closestCost = cost;
        } else if (diff == minDiff && cost < closestCost) {
            closestCost = cost;
        }
        return;
    }

    dfs(cost, target, toppingCosts, toppingCostsSize, index + 1);
    dfs(cost + toppingCosts[index], target, toppingCosts, toppingCostsSize, index + 1);
    dfs(cost + 2 * toppingCosts[index], target, toppingCosts, toppingCostsSize, index + 1);
}

int closestCost(int* baseCosts, int baseCostsSize, int* toppingCosts, int toppingCostsSize, int target) {
    minDiff = INT_MAX;
    closestCost = 0;

    for (int i = 0; i < baseCostsSize; i++) {
        dfs(baseCosts[i], target, toppingCosts, toppingCostsSize, 0);
    }

    return closestCost;
}