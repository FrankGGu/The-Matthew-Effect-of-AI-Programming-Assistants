#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long putMarbles(int* weights, int weightsSize, int k) {
    int num_splits_available = weightsSize - 1;

    if (k - 1 == 0 || k - 1 == num_splits_available) {
        return 0;
    }

    int* border_costs = (int*)malloc(num_splits_available * sizeof(int));

    for (int i = 0; i < num_splits_available; i++) {
        border_costs[i] = weights[i] + weights[i+1];
    }

    qsort(border_costs, num_splits_available, sizeof(int), compare);

    long long min_sum_of_splits = 0;
    long long max_sum_of_splits = 0;

    for (int i = 0; i < k - 1; i++) {
        min_sum_of_splits += border_costs[i];
    }

    for (int i = 0; i < k - 1; i++) {
        max_sum_of_splits += border_costs[num_splits_available - 1 - i];
    }

    long long result = max_sum_of_splits - min_sum_of_splits;

    free(border_costs);

    return result;
}