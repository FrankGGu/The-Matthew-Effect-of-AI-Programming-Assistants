#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBalancedPermutations(int n) {
    if (n % 2 != 0) {
        return 0;
    }

    long long dp[n / 2 + 1];
    dp[0] = 1;

    for (int i = 1; i <= n / 2; i++) {
        dp[i] = dp[i - 1] * (4 * i - 2) / (i + 1);
    }

    return (int)dp[n/2];
}