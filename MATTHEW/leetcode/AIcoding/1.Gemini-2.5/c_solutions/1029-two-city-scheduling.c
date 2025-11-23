#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *personA = *(int **)a;
    int *personB = *(int **)b;
    // Sort by the difference (costA - costB)
    // A smaller difference means it's relatively cheaper to send to A.
    return (personA[0] - personA[1]) - (personB[0] - personB[1]);
}

int twoCitySchedCost(int** costs, int costsSize, int* costsColSize) {
    qsort(costs, costsSize, sizeof(int*), compare);

    int totalCost = 0;
    int n = costsSize / 2;

    // Send the first n people (those with the smallest (costA - costB) differences) to City A
    for (int i = 0; i < n; i++) {
        totalCost += costs[i][0];
    }

    // Send the remaining n people to City B
    for (int i = n; i < costsSize; i++) {
        totalCost += costs[i][1];
    }

    return totalCost;
}