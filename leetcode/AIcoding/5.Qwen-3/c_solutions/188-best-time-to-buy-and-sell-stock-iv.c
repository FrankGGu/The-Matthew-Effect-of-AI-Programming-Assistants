#include <stdio.h>
#include <stdlib.h>

int maxProfit(int k, int* prices, int pricesSize) {
    if (pricesSize < 2 || k == 0)
        return 0;
    if (k >= pricesSize / 2)
        return 0;

    int* dp = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i <= k; i++)
        dp[i] = -prices[0];

    for (int i = 1; i < pricesSize; i++) {
        for (int j = 1; j <= k; j++) {
            dp[j] = fmax(dp[j], dp[j - 1] - prices[i]);
        }
    }

    int result = 0;
    for (int i = 0; i <= k; i++)
        result = fmax(result, dp[i]);

    free(dp);
    return result;
}