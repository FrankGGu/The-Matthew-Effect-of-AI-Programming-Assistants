#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumRobots(int* costs, int costsSize, int* ranks, int ranksSize, int budget) {
    int* indices = (int*)malloc(costsSize * sizeof(int));
    for (int i = 0; i < costsSize; i++) {
        indices[i] = i;
    }

    qsort(indices, costsSize, sizeof(int), compare);

    int* sortedCosts = (int*)malloc(costsSize * sizeof(int));
    int* sortedRanks = (int*)malloc(ranksSize * sizeof(int));

    for (int i = 0; i < costsSize; i++) {
        sortedCosts[i] = costs[indices[i]];
        sortedRanks[i] = ranks[indices[i]];
    }

    int maxRobots = 0;
    int totalCost = 0;
    int count = 0;

    for (int i = 0; i < costsSize; i++) {
        totalCost += sortedCosts[i];
        count++;

        while (totalCost > budget) {
            totalCost -= sortedCosts[i - count + 1];
            count--;
        }

        if (count > maxRobots) {
            maxRobots = count;
        }
    }

    free(sortedCosts);
    free(sortedRanks);
    free(indices);

    return maxRobots;
}