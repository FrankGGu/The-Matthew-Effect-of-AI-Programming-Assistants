#include <stdio.h>
#include <stdlib.h>

int dp[1001];

int waysToReachK(int k) {
    if (k == 0) return 1;
    if (k < 0) return 0;
    if (dp[k] != -1) return dp[k];
    dp[k] = waysToReachK(k - 1) + waysToReachK(k - 2);
    return dp[k];
}

int numberOfWays(int k) {
    for (int i = 0; i <= k; i++) {
        dp[i] = -1;
    }
    return waysToReachK(k);
}