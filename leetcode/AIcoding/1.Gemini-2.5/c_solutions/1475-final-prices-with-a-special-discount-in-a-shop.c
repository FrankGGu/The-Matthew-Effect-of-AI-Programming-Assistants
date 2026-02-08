#include <stdlib.h>

int* finalPrices(int* prices, int pricesSize, int* returnSize) {
    int* result = (int*)malloc(pricesSize * sizeof(int));
    *returnSize = pricesSize;

    for (int i = 0; i < pricesSize; i++) {
        int discount = 0;
        for (int j = i + 1; j < pricesSize; j++) {
            if (prices[j] <= prices[i]) {
                discount = prices[j];
                break;
            }
        }
        result[i] = prices[i] - discount;
    }

    return result;
}