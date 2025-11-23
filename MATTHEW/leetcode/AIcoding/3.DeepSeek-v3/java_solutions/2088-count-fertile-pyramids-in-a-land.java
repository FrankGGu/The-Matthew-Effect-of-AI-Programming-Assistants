class Solution {
    public int countPyramids(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[m][n];
        int res = 0;

        for (int i = m - 1; i >= 0; --i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    dp[i][j] = 0;
                } else {
                    if (i == m - 1 || j == 0 || j == n - 1) {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = Math.min(dp[i + 1][j - 1], Math.min(dp[i + 1][j], dp[i + 1][j + 1])) + 1;
                    }
                    res += dp[i][j] - 1;
                }
            }
        }

        dp = new int[m][n];
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    dp[i][j] = 0;
                } else {
                    if (i == 0 || j == 0 || j == n - 1) {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = Math.min(dp[i - 1][j - 1], Math.min(dp[i - 1][j], dp[i - 1][j + 1])) + 1;
                    }
                    res += dp[i][j] - 1;
                }
            }
        }

        return res;
    }
}