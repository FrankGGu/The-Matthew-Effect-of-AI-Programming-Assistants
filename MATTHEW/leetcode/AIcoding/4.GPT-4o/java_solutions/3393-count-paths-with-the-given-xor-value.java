class Solution {
    public int countPaths(int[][] grid, int x) {
        int m = grid.length, n = grid[0].length;
        int[][][] dp = new int[m][n][1024];
        dp[0][0][grid[0][0]] = 1;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < 1024; k++) {
                    if (dp[i][j][k] > 0) {
                        if (i + 1 < m) {
                            dp[i + 1][j][k ^ grid[i + 1][j]] += dp[i][j][k];
                        }
                        if (j + 1 < n) {
                            dp[i][j + 1][k ^ grid[i][j + 1]] += dp[i][j][k];
                        }
                    }
                }
            }
        }
        return dp[m - 1][n - 1][x];
    }
}