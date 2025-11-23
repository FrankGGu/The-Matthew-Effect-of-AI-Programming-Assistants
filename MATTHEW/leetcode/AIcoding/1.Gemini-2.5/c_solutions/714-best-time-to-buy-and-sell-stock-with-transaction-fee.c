#include <stdio.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxProfit(int* prices, int pricesSize, int fee) {
    if (pricesSize <= 1) {
        return 0;
    }

    int hold = -prices[0];
    int notHold = 0;

    for (int i = 1; i < pricesSize; i++) {
        int prevHold = hold;
        int prevNotHold = notHold;

        hold = max(prevHold, prevNotHold - prices[i]);
        notHold = max(prevNotHold, prevHold + prices[i] - fee);
    }

    return notHold;
}