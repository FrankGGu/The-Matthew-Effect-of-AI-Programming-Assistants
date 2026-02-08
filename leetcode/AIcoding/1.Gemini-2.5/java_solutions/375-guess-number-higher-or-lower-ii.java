class Solution {
    public int getMoneyAmount(int n) {
        // dp[i][j] represents the minimum money needed to guarantee a win
        // if the number is between i and j (inclusive).
        // The size is n+2 to handle out-of-bounds access for k-1 and k+1
        // (e.g., dp[i][i-1] or dp[j+1][j] which represent empty ranges and should be 0).
        int[][] dp = new int[n + 2][n + 2];

        // Iterate on the length of the range (len)
        // len = 1 means dp[i][i], which is 0 (no cost if only one choice)
        // We start from len = 2.
        for (int len = 2; len <= n; len++) {
            // Iterate on the starting point of the range (i)
            for (int i = 1; i <= n - len + 1; i++) {
                // Calculate the ending point of the range (j)
                int j = i + len - 1;

                // Initialize dp[i][j] to a very large value
                dp[i][j] = Integer.MAX_VALUE;

                // Iterate on all possible guess numbers (k) within the range [i, j]
                for (int k = i; k <= j; k++) {
                    // If we guess k:
                    // 1. We pay k.
                    // 2. If the actual number is less than k, we need to solve for range [i, k-1].
                    //    The cost for this is dp[i][k-1].
                    // 3. If the actual number is greater than k, we need to solve for range [k+1, j].
                    //    The cost for this is dp[k+1][j].
                    // To guarantee a win, we must consider the worst-case scenario after guessing k,
                    // which is the maximum of the costs from the two subproblems.
                    // So, the total cost for guessing k is k + max(dp[i][k-1], dp[k+1][j]).

                    // We want to choose k that minimizes this worst-case cost.
                    int cost = k + Math.max(dp[i][k - 1], dp[k + 1][j]);
                    dp[i][j] = Math.min(dp[i][j], cost);
                }
            }
        }

        // The result is the minimum money needed for the range [1, n]
        return dp[1][n];
    }
}