#include <stdio.h>
#include <stdlib.h>

int maximumSpending(int* prices, int pricesSize) {
    int* sorted = (int*)malloc(pricesSize * sizeof(int));
    for (int i = 0; i < pricesSize; i++) {
        sorted[i] = prices[i];
    }

    for (int i = 0; i < pricesSize - 1; i++) {
        for (int j = 0; j < pricesSize - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }

    int total = 0;
    for (int i = 0; i < pricesSize; i++) {
        total += sorted[i] * (i + 1);
    }

    free(sorted);
    return total;
}