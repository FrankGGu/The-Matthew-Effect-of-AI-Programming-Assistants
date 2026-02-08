#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int*** dp;

int solve(int zeros, int ones, int m) {
    if (zeros < 0 || ones < 0) return 0;
    if (zeros == 0 && ones == 0) return 1;
    if (dp[zeros][ones][m] != -1) return dp[zeros][ones][m];

    long long res = 0;
    res += solve(zeros - 1, ones, 0);
    if (m < 1) {
        res += solve(zeros, ones - 1, 1);
    }

    res %= 1000000007;

    return dp[zeros][ones][m] = (int)res;
}

int countArray(int n, int k) {
    dp = (int***)malloc((n + 1) * sizeof(int**));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int**)malloc((n + 1) * sizeof(int*));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = (int*)malloc(2 * sizeof(int));
            dp[i][j][0] = dp[i][j][1] = -1;
        }
    }

    int zeros = n - k;
    int ones = k;
    int result = solve(zeros, ones, 0);

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}