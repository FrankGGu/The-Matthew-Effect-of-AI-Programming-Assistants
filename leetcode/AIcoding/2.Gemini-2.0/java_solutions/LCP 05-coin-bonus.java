class Solution {
    public int coinBonus(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        dp[0][0] = grid[0][0];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) continue;
                int up = (i > 0) ? dp[i - 1][j] : 0;
                int left = (j > 0) ? dp[i][j - 1] : 0;

                if (i > 0 && j > 0) {
                    dp[i][j] = Math.max(up, left) + grid[i][j];
                } else if (i > 0) {
                    dp[i][j] = up + grid[i][j];
                } else {
                    dp[i][j] = left + grid[i][j];
                }
            }
        }

        return dp[m - 1][n - 1];
    }
}