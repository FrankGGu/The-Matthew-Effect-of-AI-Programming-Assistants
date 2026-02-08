#include <limits.h>
#include <stdlib.h>

int coinChange(int* coins, int coinsSize, int amount) {
    if (amount < 0) {
        return -1;
    }
    if (amount == 0) {
        return 0;
    }

    int* dp = (int*)malloc((amount + 1) * sizeof(int));
    if (dp == NULL) {
        return -1; // Memory allocation failed
    }

    dp[0] = 0;
    for (int i = 1; i <= amount; i++) {
        dp[i] = INT_MAX;
    }

    for (int i = 1; i <= amount; i++) {
        for (int j = 0; j < coinsSize; j++) {
            if (coins[j] <= i) {
                if (dp[i - coins[j]] != INT_MAX) {
                    if (dp[i - coins[j]] + 1 < dp[i]) {
                        dp[i] = dp[i - coins[j]] + 1;
                    }
                }
            }
        }
    }

    int result = (dp[amount] == INT_MAX) ? -1 : dp[amount];
    free(dp);
    return result;
}