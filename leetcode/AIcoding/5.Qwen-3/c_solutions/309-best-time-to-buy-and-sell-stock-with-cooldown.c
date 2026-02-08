#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize < 2) return 0;

    int* dp = (int*)malloc(pricesSize * sizeof(int));
    int* cooldown = (int*)malloc(pricesSize * sizeof(int));

    dp[0] = 0;
    cooldown[0] = -prices[0];

    for (int i = 1; i < pricesSize; i++) {
        dp[i] = max(dp[i - 1], cooldown[i - 1] + prices[i]);
        cooldown[i] = max(cooldown[i - 1], dp[i - 1] - prices[i]);
    }

    int result = dp[pricesSize - 1];
    free(dp);
    free(cooldown);
    return result;
}