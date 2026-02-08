#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int coinChange(int* coins, int coinsSize, int amount) {
    int* dp = (int*)malloc((amount + 1) * sizeof(int));
    for (int i = 0; i <= amount; i++) {
        dp[i] = amount + 1;
    }
    dp[0] = 0;

    for (int i = 0; i < coinsSize; i++) {
        for (int j = coins[i]; j <= amount; j++) {
            if (dp[j - coins[i]] + 1 < dp[j]) {
                dp[j] = dp[j - coins[i]] + 1;
            }
        }
    }

    int result = (dp[amount] == amount + 1) ? -1 : dp[amount];
    free(dp);
    return result;
}