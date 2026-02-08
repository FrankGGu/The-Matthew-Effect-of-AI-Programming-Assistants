#include <stdio.h>
#include <stdlib.h>

int minCost(int** costs, int costsSize, int* costsColSize) {
    if (costsSize == 0) return 0;
    for (int i = 1; i < costsSize; i++) {
        costs[i][0] += (costs[i-1][1] < costs[i-1][2] ? costs[i-1][1] : costs[i-1][2]);
        costs[i][1] += (costs[i-1][0] < costs[i-1][2] ? costs[i-1][0] : costs[i-1][2]);
        costs[i][2] += (costs[i-1][0] < costs[i-1][1] ? costs[i-1][0] : costs[i-1][1]);
    }
    return (costs[costsSize-1][0] < costs[costsSize-1][1] ? costs[costsSize-1][0] : costs[costsSize-1][1]) < costs[costsSize-1][2] ? costs[costsSize-1][0] : costs[costsSize-1][1];
}