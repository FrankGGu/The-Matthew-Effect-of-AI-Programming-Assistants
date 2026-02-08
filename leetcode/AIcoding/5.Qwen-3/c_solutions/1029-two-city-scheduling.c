#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int twoCitySchedCost(int* costs, int costsSize) {
    int* diff = (int*)malloc(costsSize * sizeof(int));
    for (int i = 0; i < costsSize; i++) {
        diff[i] = costs[i][1] - costs[i][0];
    }
    qsort(diff, costsSize, sizeof(int), compare);
    int total = 0;
    for (int i = 0; i < costsSize / 2; i++) {
        total += costs[i][0] + diff[i];
    }
    free(diff);
    return total;
}