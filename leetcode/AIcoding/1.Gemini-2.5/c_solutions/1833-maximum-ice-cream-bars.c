#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxIceCream(int* costs, int costsSize, int coins) {
    qsort(costs, costsSize, sizeof(int), compareIntegers);

    int barsCount = 0;
    for (int i = 0; i < costsSize; i++) {
        if (coins >= costs[i]) {
            coins -= costs[i];
            barsCount++;
        } else {
            break;
        }
    }
    return barsCount;
}