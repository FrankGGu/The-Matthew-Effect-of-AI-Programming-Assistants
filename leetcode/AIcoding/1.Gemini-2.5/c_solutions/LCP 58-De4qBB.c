#include <stdlib.h>

#define MOD 1000000007

int numTilings(int n) {
    if (n == 0) {
        return 1;
    }
    if (n == 1) {
        return 1;
    }
    if (n == 2) {
        return 5;
    }

    long long dp_i_minus_3 = 1; // Corresponds to dp[0]
    long long dp_i_minus_2 = 1; // Corresponds to dp[1]
    long long dp_i_minus_1 = 5; // Corresponds to dp[2]
    long long current_dp;

    for (int i = 3; i <= n; i++) {
        // The recurrence relation for LeetCode 790 (Domino and Tromino Tiling)
        // is dp[i] = (2 * dp[i-1] + dp[i-3]) % MOD.
        // Intermediate calculations should use long long to prevent overflow before modulo.
        current_dp = (2 * dp_i_minus_1 + dp_i_minus_3) % MOD;

        // Shift values for the next iteration
        dp_i_minus_3 = dp_i_minus_2;
        dp_i_minus_2 = dp_i_minus_1;
        dp_i_minus_1 = current_dp;
    }

    return (int)dp_i_minus_1;
}