#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProfit(int k, int* prices, int pricesSize) {
    if (pricesSize <= 1 || k == 0) {
        return 0;
    }

    if (k >= pricesSize / 2) {
        int profit = 0;
        for (int i = 1; i < pricesSize; i++) {
            if (prices[i] > prices[i - 1]) {
                profit += prices[i] - prices[i - 1];
            }
        }
        return profit;
    }

    int dp[k + 1][pricesSize];

    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < pricesSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= k; i++) {
        int maxDiff = -prices[0];
        for (int j = 1; j < pricesSize; j++) {
            dp[i][j] = (dp[i][j - 1] > (maxDiff + prices[j])) ? dp[i][j - 1] : (maxDiff + prices[j]);
            maxDiff = (maxDiff > (dp[i - 1][j] - prices[j])) ? maxDiff : (dp[i - 1][j] - prices[j]);
        }
    }

    return dp[k][pricesSize - 1];
}