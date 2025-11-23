#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSteps(int n) {
    if (n <= 1) return 0;
    int dp[n + 1];
    dp[1] = 0;
    for (int i = 2; i <= n; i++) {
        dp[i] = i;
        for (int j = 2; j * j <= i; j++) {
            if (i % j == 0) {
                dp[i] = dp[j] + (i / j);
                break;
            }
        }
    }
    return dp[n];
}