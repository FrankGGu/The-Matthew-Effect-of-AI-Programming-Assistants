class Solution {
    public int countHousePlacements(int n) {
        long MOD = 1_000_000_007L;

        // dp[i] represents the number of ways to place houses on 'i' plots on a single side of the street.
        // dp[0] = 1 (one way to arrange 0 plots: empty)
        // dp[1] = 2 (two ways to arrange 1 plot: empty or house)
        // dp[i] = dp[i-1] (if plot 'i' is empty) + dp[i-2] (if plot 'i' has a house, then plot 'i-1' must be empty)
        // This is a Fibonacci-like sequence.

        long prev2 = 1; // Corresponds to dp[0]
        long prev1 = 2; // Corresponds to dp[1]

        if (n == 0) {
            // As per problem constraints, n >= 1. This case is technically not needed.
            // If it were allowed, 1 way for one side, so 1*1 = 1 total.
            return 1;
        }
        if (n == 1) {
            // dp[1] = 2 ways for one side. Total ways = 2 * 2 = 4.
            return 4;
        }

        // Calculate dp[n] iteratively
        for (int i = 2; i <= n; i++) {
            long current = (prev1 + prev2) % MOD;
            prev2 = prev1;
            prev1 = current;
        }

        // After the loop, prev1 holds dp[n], the number of ways for one side of the street.
        // Since the two sides are independent, the total number of ways is dp[n] * dp[n].
        long totalWays = (prev1 * prev1) % MOD;

        return (int) totalWays;
    }
}