#include <stdlib.h>
#include <limits.h> // Not strictly needed if using amount + 1 for infinity
#include <string.h> // Not strictly needed if using a loop for initialization

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

    int max_val = amount + 1; // Represents infinity

    for (int i = 0; i <= amount; ++i) {
        dp[i] = max_val;
    }
    dp[0] = 0;

    for (int i = 1; i <= amount; ++i) {
        for (int j = 0; j < coinsSize; ++j) {
            if (coins[j] <= i) {
                if (dp[i - coins[j]] != max_val) {
                    if (dp[i - coins[j]] + 1 < dp[i]) {
                        dp[i] = dp[i - coins[j]] + 1;
                    }
                }
            }
        }
    }

    int result = (dp[amount] == max_val) ? -1 : dp[amount];

    free(dp);

    return result;
}