class Solution {
    public int minFallingPathSum(int[][] grid) {
        int n = grid.length;

        int[] prev_dp = new int[n];
        for (int j = 0; j < n; j++) {
            prev_dp[j] = grid[0][j];
        }

        for (int i = 1; i < n; i++) {
            int min1 = Integer.MAX_VALUE, idx1 = -1;
            int min2 = Integer.MAX_VALUE, idx2 = -1;

            // Find the two smallest values and their indices in prev_dp
            // min1 is the smallest, min2 is the second smallest
            for (int k = 0; k < n; k++) {
                if (prev_dp[k] < min1) {
                    min2 = min1;
                    idx2 = idx1;
                    min1 = prev_dp[k];
                    idx1 = k;
                } else if (prev_dp[k] < min2) {
                    min2 = prev_dp[k];
                    idx2 = k;
                }
            }

            int[] curr_dp = new int[n];
            for (int j = 0; j < n; j++) {
                if (j == idx1) {
                    // If current column is the one with the smallest sum from previous row,
                    // we must use the second smallest sum.
                    curr_dp[j] = grid[i][j] + min2;
                } else {
                    // Otherwise, we can use the smallest sum from previous row.
                    curr_dp[j] = grid[i][j] + min1;
                }
            }
            prev_dp = curr_dp;
        }

        int overallMin = Integer.MAX_VALUE;
        for (int val : prev_dp) {
            overallMin = Math.min(overallMin, val);
        }

        return overallMin;
    }
}