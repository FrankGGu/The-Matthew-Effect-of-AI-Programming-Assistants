#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProfit(int* prices, int pricesSize, int fee) {
    int buy = -prices[0];
    int sell = 0;
    for (int i = 1; i < pricesSize; i++) {
        int prev_buy = buy;
        buy = (buy > sell - prices[i]) ? buy : (sell - prices[i]);
        sell = (sell > prev_buy + prices[i] - fee) ? sell : (prev_buy + prices[i] - fee);
    }
    return sell;
}