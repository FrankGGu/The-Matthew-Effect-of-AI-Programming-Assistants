class Solution {
    public boolean hasValidPath(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        if ((m + n - 1) % 2 != 0) {
            return false;
        }

        if (grid[0][0] == ')' || grid[m - 1][n - 1] == '(') {
            return false;
        }

        boolean[][][] dp = new boolean[m][n][m + n];
        dp[0][0][1] = true;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k <= m + n -1; k++) {
                    if (dp[i][j][k]) {
                        int nextBalance = (grid[i][j] == '(') ? k + 1 : k - 1;
                        if (nextBalance >= 0 && nextBalance <= m + n -1) {
                            if (i + 1 < m) {
                                dp[i + 1][j][nextBalance] = true;
                            }
                            if (j + 1 < n) {
                                dp[i][j + 1][nextBalance] = true;
                            }
                        }
                    }
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
}