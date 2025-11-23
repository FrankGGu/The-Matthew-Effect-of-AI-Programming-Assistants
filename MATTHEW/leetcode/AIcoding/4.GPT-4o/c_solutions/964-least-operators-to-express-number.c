#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int leastOpsExpressTarget(int x, int target) {
    if (target == 0) return 0;
    if (target == 1) return 1;

    int* dp = (int*)malloc((target + 1) * sizeof(int));
    for (int i = 0; i <= target; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;
    dp[1] = 1;

    for (int i = 1; i <= target; i++) {
        for (int j = 1; j * x <= i; j++) {
            int expr = j + dp[i - j * x];
            if (expr < dp[i]) {
                dp[i] = expr;
            }
        }
        for (int j = 1; j <= i / 2; j++) {
            int expr = 1 + dp[j] + dp[i - j];
            if (expr < dp[i]) {
                dp[i] = expr;
            }
        }
    }

    int result = dp[target];
    free(dp);
    return result;
}