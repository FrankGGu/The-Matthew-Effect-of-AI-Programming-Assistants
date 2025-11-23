#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxSpending(int** items, int itemsSize, int* itemsColSize) {
    int totalItems = 0;
    for (int i = 0; i < itemsSize; i++) {
        totalItems += itemsColSize[i];
    }

    int* allPrices = (int*)malloc(totalItems * sizeof(int));
    if (allPrices == NULL) {
        return -1; 
    }

    int k = 0;
    for (int i = 0; i < itemsSize; i++) {
        for (int j = 0; j < itemsColSize[i]; j++) {
            allPrices[k++] = items[i][j];
        }
    }

    qsort(allPrices, totalItems, sizeof(int), compareIntegers);

    long long totalSpending = 0;
    for (int i = 0; i < totalItems; i++) {
        totalSpending += (long long)allPrices[i] * (i + 1);
    }

    free(allPrices);

    return totalSpending;
}