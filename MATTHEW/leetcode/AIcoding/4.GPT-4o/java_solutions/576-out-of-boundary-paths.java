class Solution {
    public int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        int mod = 1000000007;
        int[][][] dp = new int[m][n][maxMove + 1];

        for (int k = 1; k <= maxMove; k++) {
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    int totalPaths = 0;
                    if (i == 0) totalPaths++;
                    if (i == m - 1) totalPaths++;
                    if (j == 0) totalPaths++;
                    if (j == n - 1) totalPaths++;

                    if (i > 0) totalPaths = (totalPaths + dp[i - 1][j][k - 1]) % mod;
                    if (i < m - 1) totalPaths = (totalPaths + dp[i + 1][j][k - 1]) % mod;
                    if (j > 0) totalPaths = (totalPaths + dp[i][j - 1][k - 1]) % mod;
                    if (j < n - 1) totalPaths = (totalPaths + dp[i][j + 1][k - 1]) % mod;

                    dp[i][j][k] = totalPaths;
                }
            }
        }

        return dp[startRow][startColumn][maxMove];
    }
}