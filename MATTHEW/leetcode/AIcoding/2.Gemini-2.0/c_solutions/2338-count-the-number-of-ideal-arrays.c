#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long C(int n, int k, long long **dp) {
    if (k < 0 || k > n) return 0;
    if (k == 0 || k == n) return 1;
    if (k == 1 || k == n - 1) return n;
    if (dp[n][k] != -1) return dp[n][k];

    dp[n][k] = (C(n - 1, k - 1, dp) + C(n - 1, k, dp)) % MOD;
    return dp[n][k];
}

int idealArrays(int n, int maxValue) {
    long long **dp = (long long **)malloc((n + maxValue + 1) * sizeof(long long *));
    for (int i = 0; i < n + maxValue + 1; i++) {
        dp[i] = (long long *)malloc((n + 1) * sizeof(long long));
        for (int j = 0; j < n + 1; j++) {
            dp[i][j] = -1;
        }
    }

    long long ans = 0;
    for (int i = 1; i <= maxValue; i++) {
        int numFactors = 0;
        int temp = i;
        for (int j = 2; j * j <= temp; j++) {
            if (temp % j == 0) {
                numFactors++;
                while (temp % j == 0) {
                    temp /= j;
                }
            }
        }
        if (temp > 1) {
            numFactors++;
        }
        ans = (ans + C(n - 1, numFactors, dp)) % MOD;
    }

    for (int i = 0; i < n + maxValue + 1; i++) {
        free(dp[i]);
    }
    free(dp);

    return (int)ans;
}