#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumCoins(int* prices, int pricesSize) {
    int *dp = (int*)malloc(sizeof(int) * (pricesSize + 1));
    dp[0] = 0;

    for (int i = 1; i <= pricesSize; i++) {
        dp[i] = prices[i-1];
        int min_val = dp[i-1];
        for (int j = 1; j <= i - 1; j++) {
            if (i - 1 - j + 1 <= i - 1 && i - 1 - j + 1 >= 0) {
                if(j <= i - 1)
                    dp[i] = fmin(dp[i], dp[i - 1 - j + 1] + prices[i-1]);
            }
        }
    }

    int result = dp[pricesSize];
    free(dp);
    return result;
}