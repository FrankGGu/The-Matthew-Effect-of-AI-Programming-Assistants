#include <stdio.h>

#define MOD 1000000007

int dp[1001][1001];

int rearrangeSticks(int n, int k) {
    // Base case: 0 sticks, 0 visible sticks, 1 way (empty arrangement)
    dp[0][0] = 1;

    // Fill the DP table
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            // Case 1: The tallest stick (stick 'i') is placed at the leftmost position.
            // It is always visible. The remaining 'i-1' sticks must be arranged
            // to have 'j-1' visible sticks among themselves.
            dp[i][j] = dp[i-1][j-1];

            // Case 2: The tallest stick (stick 'i') is NOT placed at the leftmost position.
            // If stick 'i' is not at the beginning, it must be hidden by the first stick
            // (which is one of the 'i-1' shorter sticks).
            // We take an arrangement of 'i-1' sticks with 'j' visible sticks.
            // There are 'i-1' possible positions to insert stick 'i' such that it is hidden
            // by the first stick and does not change the count of visible sticks.
            // The multiplication (long long)(i - 1) ensures intermediate product doesn't overflow
            // before modulo.
            dp[i][j] = (dp[i][j] + (long long)(i - 1) * dp[i-1][j]) % MOD;
        }
    }

    return dp[n][k];
}