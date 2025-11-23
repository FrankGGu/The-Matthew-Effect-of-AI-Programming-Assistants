#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCostToCut(int n, int* queries, int queriesSize) {
    int m = queriesSize;
    int *sortedQueries = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        sortedQueries[i] = queries[i];
    }
    qsort(sortedQueries, m, sizeof(int), cmp);

    int *costs = (int*)malloc((m + 1) * sizeof(int));
    costs[0] = 0;
    for (int i = 1; i <= m; i++) {
        costs[i] = costs[i - 1] + sortedQueries[i - 1];
    }

    int total = 0;
    for (int i = 1; i <= m; i++) {
        total += (n - sortedQueries[i - 1]) * (i);
    }

    free(sortedQueries);
    free(costs);
    return total;
}