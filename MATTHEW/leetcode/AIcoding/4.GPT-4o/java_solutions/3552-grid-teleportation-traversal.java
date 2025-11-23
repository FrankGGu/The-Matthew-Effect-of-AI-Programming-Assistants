class Solution {
    public int gridTeleportationTraversal(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = grid[0][0];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i + 1 < m) {
                    dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j] + grid[i + 1][j]);
                }
                if (j + 1 < n) {
                    dp[i][j + 1] = Math.min(dp[i][j + 1], dp[i][j] + grid[i][j + 1]);
                }
            }
        }

        return dp[m - 1][n - 1];
    }
}