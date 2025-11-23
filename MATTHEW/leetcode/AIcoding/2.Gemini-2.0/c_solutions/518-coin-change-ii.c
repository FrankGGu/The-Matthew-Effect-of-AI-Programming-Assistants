#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int change(int amount, int* coins, int coinsSize) {
    int* dp = (int*)malloc((amount + 1) * sizeof(int));
    for (int i = 0; i <= amount; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < coinsSize; i++) {
        for (int j = coins[i]; j <= amount; j++) {
            dp[j] += dp[j - coins[i]];
        }
    }

    int result = dp[amount];
    free(dp);
    return result;
}