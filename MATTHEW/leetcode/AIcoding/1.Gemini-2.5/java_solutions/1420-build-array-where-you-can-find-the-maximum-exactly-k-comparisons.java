class Solution {
    public int numOfArrays(int n, int m, int k) {
        final int MOD = 1_000_000_007;

        // dp[i][j][c] = number of ways to build an array of length i,
        // with maximum element j, using exactly c comparisons.
        long[][][] dp = new long[n + 1][m + 1][k + 1];

        // Base case: For an array of length 1, if the element is j,
        // then the maximum is j, and 1 comparison is made.
        for (int j = 1; j <= m; j++) {
            dp[1][j][1] = 1;
        }

        // Fill DP table
        for (int i = 2; i <= n; i++) { // Current array length
            for (int c = 1; c <= k; c++) { // Current number of comparisons
                long sumPrevMaxWays = 0; // Accumulates sum(dp[i-1][p][c-1] for p in 1 to j-1)
                for (int j = 1; j <= m; j++) { // Current maximum element
                    // Case 1: The i-th element is j, and j is a new maximum.
                    // This means the previous i-1 elements had a maximum p < j,
                    // and used c-1 comparisons.
                    // sumPrevMaxWays already holds sum(dp[i-1][p][c-1] for p in 1 to j-1)
                    dp[i][j][c] = (dp[i][j][c] + sumPrevMaxWays) % MOD;

                    // Case 2: The i-th element x (1 <= x <= j) is NOT a new maximum.
                    // This means the previous i-1 elements already had maximum j,
                    // and used c comparisons.
                    // We can place any number from 1 to j at the i-th position.
                    dp[i][j][c] = (dp[i][j][c] + dp[i - 1][j][c] * j) % MOD;

                    // Update sumPrevMaxWays for the next iteration of j.
                    // For j+1, we will need sum(dp[i-1][p][c-1] for p in 1 to j),
                    // which is the current sumPrevMaxWays + dp[i-1][j][c-1].
                    sumPrevMaxWays = (sumPrevMaxWays + dp[i - 1][j][c - 1]) % MOD;
                }
            }
        }

        // Sum up all ways for an array of length n, with exactly k comparisons,
        // and any possible maximum element from 1 to m.
        long totalWays = 0;
        for (int j = 1; j <= m; j++) {
            totalWays = (totalWays + dp[n][j][k]) % MOD;
        }

        return (int) totalWays;
    }
}