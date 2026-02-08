#include <stdio.h>
#include <stdlib.h>

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize < 2) return 0;

    int n = pricesSize;
    int* buy = (int*)malloc(n * sizeof(int));
    int* sell = (int*)malloc(n * sizeof(int));
    int* hold = (int*)malloc(n * sizeof(int));

    buy[0] = -prices[0];
    sell[0] = 0;
    hold[0] = -prices[0];

    for (int i = 1; i < n; i++) {
        buy[i] = fmax(hold[i-1] - prices[i], buy[i-1]);
        sell[i] = fmax(buy[i-1] + prices[i], sell[i-1]);
        hold[i] = fmax(sell[i-1] - prices[i], hold[i-1]);
    }

    int result = fmax(sell[n-1], hold[n-1]);
    free(buy);
    free(sell);
    free(hold);
    return result;
}