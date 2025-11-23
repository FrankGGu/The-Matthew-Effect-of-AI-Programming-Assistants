#include <stdio.h>
#include <stdlib.h>

int numTrees(int n) {
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    dp[0] = 1;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            dp[i] += dp[j] * dp[i - j - 1];
        }
    }
    int result = dp[n];
    free(dp);
    return result;
}