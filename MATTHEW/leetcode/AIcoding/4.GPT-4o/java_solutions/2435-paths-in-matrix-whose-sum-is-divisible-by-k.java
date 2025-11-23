class Solution {
    public int countPaths(int[][] grid, int k) {
        int m = grid.length, n = grid[0].length;
        int[][][] dp = new int[m][n][k];
        dp[0][0][grid[0][0] % k] = 1;
        int mod = 1000000007;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int modVal = 0; modVal < k; modVal++) {
                    if (dp[i][j][modVal] > 0) {
                        if (i + 1 < m) {
                            int newMod = (modVal + grid[i + 1][j]) % k;
                            dp[i + 1][j][newMod] = (dp[i + 1][j][newMod] + dp[i][j][modVal]) % mod;
                        }
                        if (j + 1 < n) {
                            int newMod = (modVal + grid[i][j + 1]) % k;
                            dp[i][j + 1][newMod] = (dp[i][j + 1][newMod] + dp[i][j][modVal]) % mod;
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < k; i++) {
            result = (result + dp[m - 1][n - 1][i]) % mod;
        }
        return result;
    }
}