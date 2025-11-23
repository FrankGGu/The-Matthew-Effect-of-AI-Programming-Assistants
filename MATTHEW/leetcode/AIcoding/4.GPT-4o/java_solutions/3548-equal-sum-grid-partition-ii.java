class Solution {
    public boolean equalPartition(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int totalSum = 0;

        for (int[] row : grid) {
            for (int num : row) {
                totalSum += num;
            }
        }

        if (totalSum % 2 != 0) return false;

        int target = totalSum / 2;
        boolean[][][] dp = new boolean[m + 1][n + 1][target + 1];
        dp[0][0][0] = true;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k <= target; k++) {
                    dp[i + 1][j][k] = dp[i][j][k];
                    if (j < n && k >= grid[i][j]) {
                        dp[i + 1][j + 1][k] = dp[i + 1][j][k] || dp[i][j][k - grid[i][j]];
                    }
                }
            }
        }

        return dp[m][n][target];
    }
}