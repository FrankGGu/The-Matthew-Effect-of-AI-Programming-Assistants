#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize < 2) {
        return 0;
    }

    int dp[2][3];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            dp[i][j] = 0;
        }
    }

    int buy1 = INT_MIN, buy2 = INT_MIN;

    for (int i = 0; i < pricesSize; i++) {
        buy1 = fmax(buy1, -prices[i]);
        dp[0][1] = fmax(dp[0][1], buy1 + prices[i]);
        buy2 = fmax(buy2, dp[0][1] - prices[i]);
        dp[0][2] = fmax(dp[0][2], buy2 + prices[i]);
    }

    return dp[0][2];
}