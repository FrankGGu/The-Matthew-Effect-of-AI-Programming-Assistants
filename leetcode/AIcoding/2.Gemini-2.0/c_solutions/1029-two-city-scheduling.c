#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int diffA = ((int*)a)[0] - ((int*)a)[1];
    int diffB = ((int*)b)[0] - ((int*)b)[1];
    return diffA - diffB;
}

int twoCitySchedCost(int** costs, int costsSize, int* costsColSize){
    qsort(costs, costsSize, sizeof(costs[0]), cmp);
    int totalCost = 0;
    for(int i = 0; i < costsSize / 2; i++){
        totalCost += costs[i][0];
    }
    for(int i = costsSize / 2; i < costsSize; i++){
        totalCost += costs[i][1];
    }
    return totalCost;
}