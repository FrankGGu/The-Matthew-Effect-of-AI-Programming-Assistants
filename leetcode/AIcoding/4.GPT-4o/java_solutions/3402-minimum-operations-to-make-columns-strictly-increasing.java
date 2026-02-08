class Solution {
    public int minOperations(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m + 1][n + 1];
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Integer.MAX_VALUE / 2;
            }
        }
        dp[0][0] = 0;

        for (int j = 1; j <= n; j++) {
            for (int i = 0; i <= m; i++) {
                for (int k = 0; k < m; k++) {
                    if (i == 0 || grid[k][j - 1] > grid[k][j - 2] || (j == 1 && i == 0)) {
                        dp[i][j] = Math.min(dp[i][j], dp[i][j - 1] + (i == 0 ? 0 : 1));
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int i = 0; i <= m; i++) {
            result = Math.min(result, dp[i][n]);
        }
        return result;
    }
}