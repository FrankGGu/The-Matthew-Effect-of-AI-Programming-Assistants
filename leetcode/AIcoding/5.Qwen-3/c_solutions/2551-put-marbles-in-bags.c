#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

long long putMarbles(int* weights, int weightsSize, int k) {
    if (k == 1 || weightsSize == 1) return 0;
    int* costs = (int*)malloc((weightsSize - 1) * sizeof(int));
    for (int i = 0; i < weightsSize - 1; i++) {
        costs[i] = weights[i] + weights[i + 1];
    }
    qsort(costs, weightsSize - 1, sizeof(int), compare);
    long long result = 0;
    for (int i = 0; i < k - 1; i++) {
        result += costs[weightsSize - 2 - i];
    }
    free(costs);
    return result;
}