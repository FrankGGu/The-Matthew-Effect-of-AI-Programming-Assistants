public class Solution {
    public int pathSum(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int[][][] dp = new int[m][n][k];
        int[][] prefix = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) {
                    prefix[i][j] = grid[i][j];
                } else if (i == 0) {
                    prefix[i][j] = prefix[i][j - 1] + grid[i][j];
                } else if (j == 0) {
                    prefix[i][j] = prefix[i - 1][j] + grid[i][j];
                } else {
                    prefix[i][j] = Math.max(prefix[i - 1][j], prefix[i][j - 1]) + grid[i][j];
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int sum = prefix[i][j];
                int mod = sum % k;
                if (mod < 0) mod += k;
                if (i == 0 && j == 0) {
                    dp[i][j][mod] = 1;
                } else {
                    if (i > 0) {
                        for (int l = 0; l < k; l++) {
                            int prevMod = (l - grid[i][j]) % k;
                            if (prevMod < 0) prevMod += k;
                            dp[i][j][l] += dp[i - 1][j][prevMod];
                        }
                    }
                    if (j > 0) {
                        for (int l = 0; l < k; l++) {
                            int prevMod = (l - grid[i][j]) % k;
                            if (prevMod < 0) prevMod += k;
                            dp[i][j][l] += dp[i][j - 1][prevMod];
                        }
                    }
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
}