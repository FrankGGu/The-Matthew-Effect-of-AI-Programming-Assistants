#include <stdlib.h>
#include <string.h>

int countGoodStrings(int low, int high, int zero, int one) {
    int MOD = 1e9 + 7;
    int* dp = (int*)malloc((high + 1) * sizeof(int));
    if (dp == NULL) {
        return -1; // Handle allocation error
    }
    memset(dp, 0, (high + 1) * sizeof(int));

    dp[0] = 1;

    for (int i = 1; i <= high; i++) {
        if (i >= zero) {
            dp[i] = (dp[i] + dp[i - zero]) % MOD;
        }
        if (i >= one) {
            dp[i] = (dp[i] + dp[i - one]) % MOD;
        }
    }

    int totalWays = 0;
    for (int i = low; i <= high; i++) {
        totalWays = (totalWays + dp[i]) % MOD;
    }

    free(dp);
    return totalWays;
}