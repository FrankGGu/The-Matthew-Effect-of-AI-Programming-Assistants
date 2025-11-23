#include <stdlib.h>
#include <string.h>

int change(int amount, int* coins, int coinsSize) {
    int* dp = (int*)malloc((amount + 1) * sizeof(int));
    if (dp == NULL) {
        return 0;
    }

    memset(dp, 0, (amount + 1) * sizeof(int));
    dp[0] = 1;

    for (int i = 0; i < coinsSize; i++) {
        int coin = coins[i];
        for (int j = coin; j <= amount; j++) {
            dp[j] += dp[j - coin];
        }
    }

    int result = dp[amount];
    free(dp);
    return result;
}