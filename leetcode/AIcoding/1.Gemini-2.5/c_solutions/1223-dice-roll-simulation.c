#include <stdlib.h>

int dieSimulator(int n, int* rollMax, int rollMaxSize) {
    long long MOD = 1e9 + 7;

    long long** dp = (long long**)malloc((n + 1) * sizeof(long long*));
    for (int i = 0; i <= n; ++i) {
        dp[i] = (long long*)calloc(6, sizeof(long long));
    }

    long long* totalWays = (long long*)calloc((n + 1), sizeof(long long));

    totalWays[0] = 1;

    for (int j = 0; j < 6; ++j) {
        dp[1][j] = 1;
        totalWays[1] = (totalWays[1] + dp[1][j]) % MOD;
    }

    for (int i = 2; i <= n; ++i) {
        for (int j = 0; j < 6; ++j) {
            dp[i][j] = totalWays[i-1];

            if (i - 1 >= rollMax[j]) {
                long long invalid_prefix_len = i - 1 - rollMax[j];
                long long invalid_prefix_count = (totalWays[invalid_prefix_len] - dp[invalid_prefix_len][j] + MOD) % MOD;

                dp[i][j] = (dp[i][j] - invalid_prefix_count + MOD) % MOD;
            }
            totalWays[i] = (totalWays[i] + dp[i][j]) % MOD;
        }
    }

    long long result = totalWays[n];

    for (int i = 0; i <= n; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(totalWays);

    return (int)result;
}