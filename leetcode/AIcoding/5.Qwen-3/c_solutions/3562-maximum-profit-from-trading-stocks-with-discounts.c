#include <stdio.h>
#include <stdlib.h>

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize <= 1) return 0;

    int* dp = (int*)malloc(pricesSize * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i < pricesSize; i++) {
        dp[i] = dp[i - 1];
        for (int j = 0; j < i; j++) {
            if (prices[j] < prices[i]) {
                dp[i] = fmax(dp[i], dp[j] + prices[i] - prices[j]);
            }
        }
    }

    int result = dp[pricesSize - 1];
    free(dp);
    return result;
}