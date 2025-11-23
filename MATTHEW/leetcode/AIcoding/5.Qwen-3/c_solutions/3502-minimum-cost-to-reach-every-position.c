#include <stdio.h>
#include <stdlib.h>

int* minCostToReachEveryPosition(int* cost, int costSize, int* returnSize) {
    *returnSize = costSize;
    int* result = (int*)malloc(sizeof(int) * costSize);
    if (!result) return NULL;

    result[0] = cost[0];
    for (int i = 1; i < costSize; i++) {
        result[i] = result[i - 1] + cost[i];
    }

    return result;
}