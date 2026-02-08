#include <stdio.h>
#include <stdlib.h>

int maxProfit(int* prices, int pricesSize) {
    int minPrice = prices[0];
    int maxProfit = 0;
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] - minPrice > maxProfit) {
            maxProfit = prices[i] - minPrice;
        }
        if (prices[i] < minPrice) {
            minPrice = prices[i];
        }
    }
    return maxProfit;
}