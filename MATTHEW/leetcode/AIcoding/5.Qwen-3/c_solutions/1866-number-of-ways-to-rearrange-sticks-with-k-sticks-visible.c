#include <stdio.h>
#include <stdlib.h>

int numWays(int n, int k) {
    if (n == 0) return 0;
    if (n == 1) return k;

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    dp[1] = k;
    dp[2] = k * (k - 1);

    for (int i = 3; i <= n; i++) {
        dp[i] = (dp[i - 1] + dp[i - 2]) * (k - 1);
    }

    int result = dp[n];
    free(dp);
    return result;
}