#include <stdio.h>
#include <stdlib.h>

int minCostToCollectAllChocolates(int* basket, int n) {
    int* freq = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < n; i++) {
        freq[basket[i]]++;
    }

    int total_cost = 0;
    for (int i = 0; i < 10001; i++) {
        if (freq[i] > 0) {
            total_cost += freq[i] * i;
        }
    }

    free(freq);
    return total_cost;
}