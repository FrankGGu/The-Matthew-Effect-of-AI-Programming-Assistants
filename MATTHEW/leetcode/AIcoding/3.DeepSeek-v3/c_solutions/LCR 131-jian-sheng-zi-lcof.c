#include <stdlib.h>

long long minCost(int* heights, int heightsSize, int targetHeight) {
    long long cost = 0;
    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] > targetHeight) {
            cost += (long long)(heights[i] - targetHeight);
        }
    }
    return cost;
}

long long minCostToCutBamboo(int* heights, int heightsSize) {
    int maxHeight = 0;
    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] > maxHeight) {
            maxHeight = heights[i];
        }
    }

    long long minCostValue = -1;
    for (int h = 0; h <= maxHeight; h++) {
        long long currentCost = minCost(heights, heightsSize, h);
        if (minCostValue == -1 || currentCost < minCostValue) {
            minCostValue = currentCost;
        }
    }

    return minCostValue;
}