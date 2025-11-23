#include <stdio.h>
#include <stdlib.h>

int peopleAwareOfSecret(int n, int k) {
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    dp[0] = 1;
    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        if (i - k >= 0) {
            dp[i] += dp[i - k];
        }
    }
    int result = dp[n];
    free(dp);
    return result;
}