#include <stdio.h>
#include <stdlib.h>

int maxProfit(int* prices, int pricesSize, int fee) {
    if (pricesSize < 2) return 0;

    int cash = 0;
    int hold = -prices[0];

    for (int i = 1; i < pricesSize; i++) {
        cash = fmax(cash, hold + prices[i] - fee);
        hold = fmax(hold, cash - prices[i]);
    }

    return cash;
}