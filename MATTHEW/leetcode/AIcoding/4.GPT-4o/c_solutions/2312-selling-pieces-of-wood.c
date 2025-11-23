#include <stdio.h>

int maxProfit(int* a, int aSize) {
    int dp[aSize + 1];
    for (int i = 0; i <= aSize; i++) {
        dp[i] = 0;
    }

    for (int i = 1; i <= aSize; i++) {
        for (int j = 1; j <= i; j++) {
            dp[i] = dp[i] > dp[i - j] + a[j - 1] ? dp[i] : dp[i - j] + a[j - 1];
        }
    }

    return dp[aSize];
}