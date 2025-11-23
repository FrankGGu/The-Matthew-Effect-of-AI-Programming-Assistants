class Solution {
    public int minSkips(int[] dist, int speed, int hoursBefore) {
        int n = dist.length;
        long[][] dp = new long[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Long.MAX_VALUE;
            }
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                dp[i][j] = Math.min(dp[i][j], (long) Math.ceil((double) dp[i - 1][j] / speed) * speed + dist[i - 1]);
                if (j > 0) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1] + dist[i - 1]);
                }
            }
        }
        for (int j = 0; j <= n; j++) {
            if (dp[n][j] <= (long) hoursBefore * speed) {
                return j;
            }
        }
        return -1;
    }
}