class Solution {
    public int uniquePaths(int m, int n) {
        int[] dp = new int[n];

        // Initialize the first row (or the base state for the single row DP)
        // All cells in the first row have 1 unique path to reach them
        for (int j = 0; j < n; j++) {
            dp[j] = 1;
        }

        // Iterate for each subsequent row (from the second row, index 1, up to m-1)
        for (int i = 1; i < m; i++) {
            // For each cell in the current row
            // dp[0] (first column) always remains 1, as there's only one way to reach it (by moving down from above)
            for (int j = 1; j < n; j++) {
                // The number of paths to reach dp[j] in the current row (i)
                // is the sum of paths from:
                // 1. The cell directly above it (dp[j] from the previous iteration/row)
                // 2. The cell to its left in the current row (dp[j-1] from the current iteration/row)
                dp[j] = dp[j] + dp[j - 1];
            }
        }

        // The last element in the dp array will contain the total unique paths
        // to reach the bottom-right corner (m-1, n-1)
        return dp[n - 1];
    }
}