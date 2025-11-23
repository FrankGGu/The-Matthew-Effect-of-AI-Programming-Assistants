#include <stdlib.h>
#include <limits.h>

int numSquares(int n) {
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j * j <= i; j++) {
            dp[i] = (dp[i] < dp[i - j * j] + 1) ? dp[i] : dp[i - j * j] + 1;
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}