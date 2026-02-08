class Solution {
    public int cherryPickup(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][][] dp = new int[m][n][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }
        dp[0][0][n - 1] = grid[0][0] + grid[0][n - 1];

        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    int maxPrev = -1;
                    for (int dj = -1; dj <= 1; dj++) {
                        for (int dk = -1; dk <= 1; dk++) {
                            int prevJ = j + dj;
                            int prevK = k + dk;
                            if (prevJ >= 0 && prevJ < n && prevK >= 0 && prevK < n && dp[i - 1][prevJ][prevK] != -1) {
                                maxPrev = Math.max(maxPrev, dp[i - 1][prevJ][prevK]);
                            }
                        }
                    }
                    if (maxPrev != -1) {
                        if (j == k) {
                            dp[i][j][k] = maxPrev + grid[i][j];
                        } else {
                            dp[i][j][k] = maxPrev + grid[i][j] + grid[i][k];
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                result = Math.max(result, dp[m - 1][j][k]);
            }
        }
        return result;
    }
}