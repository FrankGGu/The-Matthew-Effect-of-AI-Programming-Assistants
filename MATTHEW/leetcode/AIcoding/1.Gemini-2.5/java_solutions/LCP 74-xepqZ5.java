class Solution {
    public long strongestBlessingForceField(int[][] blessings) {
        int n = blessings.length;
        int m = blessings[0].length;

        long[][] dp = new long[n][m];

        dp[0][0] = blessings[0][0];

        for (int c = 1; c < m; c++) {
            dp[0][c] = blessings[0][c] + dp[0][c - 1];
        }

        for (int r = 1; r < n; r++) {
            dp[r][0] = blessings[r][0] + dp[r - 1][0];
        }

        for (int r = 1; r < n; r++) {
            for (int c = 1; c < m; c++) {
                dp[r][c] = blessings[r][c] + Math.max(dp[r - 1][c], dp[r][c - 1]);
            }
        }

        return dp[n - 1][m - 1];
    }
}