class Solution {
    public int minimumLevels(int[][] points) {
        int n = points.length;
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= i; j++) {
                if (dp[i][j] != Integer.MAX_VALUE) {
                    dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j]);
                    dp[i + 1][j + 1] = Math.min(dp[i + 1][j + 1], dp[i][j] + points[i][0]);
                    dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j] + points[i][1]);
                }
            }
        }

        for (int i = 0; i <= n; i++) {
            if (dp[n][i] != Integer.MAX_VALUE) {
                return i;
            }
        }
        return -1;
    }
}