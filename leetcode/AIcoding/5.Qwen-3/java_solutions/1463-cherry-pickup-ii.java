public class Solution {
    public int cherryPickupII(int[][] grid) {
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

        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                dp[0][j][k] = grid[0][j] + (j == k ? 0 : grid[0][k]);
            }
        }

        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    int maxCherries = 0;
                    for (int dj = -1; dj <= 1; dj++) {
                        for (int dk = -1; dk <= 1; dk++) {
                            int prevJ = j + dj;
                            int prevK = k + dk;
                            if (prevJ >= 0 && prevJ < n && prevK >= 0 && prevK < n) {
                                maxCherries = Math.max(maxCherries, dp[i - 1][prevJ][prevK]);
                            }
                        }
                    }
                    dp[i][j][k] = maxCherries + grid[i][j] + (j == k ? 0 : grid[i][k]);
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