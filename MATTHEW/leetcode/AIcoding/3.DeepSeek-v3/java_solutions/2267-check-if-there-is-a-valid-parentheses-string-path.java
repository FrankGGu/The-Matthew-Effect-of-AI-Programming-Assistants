class Solution {
    public boolean hasValidPath(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        if ((m + n - 1) % 2 != 0) {
            return false;
        }
        boolean[][][] dp = new boolean[m][n][(m + n + 1) / 2];
        if (grid[0][0] == '(') {
            dp[0][0][1] = true;
        } else {
            return false;
        }
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) {
                    continue;
                }
                char c = grid[i][j];
                for (int k = 0; k < dp[i][j].length; k++) {
                    if (i > 0 && dp[i - 1][j][k]) {
                        if (c == '(') {
                            if (k + 1 < dp[i][j].length) {
                                dp[i][j][k + 1] = true;
                            }
                        } else if (k - 1 >= 0) {
                            dp[i][j][k - 1] = true;
                        }
                    }
                    if (j > 0 && dp[i][j - 1][k]) {
                        if (c == '(') {
                            if (k + 1 < dp[i][j].length) {
                                dp[i][j][k + 1] = true;
                            }
                        } else if (k - 1 >= 0) {
                            dp[i][j][k - 1] = true;
                        }
                    }
                }
            }
        }
        return dp[m - 1][n - 1][0];
    }
}