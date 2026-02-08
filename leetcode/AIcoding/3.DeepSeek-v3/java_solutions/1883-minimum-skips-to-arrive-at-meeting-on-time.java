class Solution {
    public int minSkips(int[] dist, int speed, int hoursBefore) {
        int n = dist.length;
        double[][] dp = new double[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Double.MAX_VALUE;
            }
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            double time = (double) dist[i - 1] / speed;
            for (int j = 0; j <= i; j++) {
                if (j > 0) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1] + time);
                }
                if (j <= i - 1) {
                    dp[i][j] = Math.min(dp[i][j], Math.ceil(dp[i - 1][j] + time - 1e-9));
                }
            }
        }

        for (int j = 0; j <= n; j++) {
            if (dp[n][j] <= hoursBefore) {
                return j;
            }
        }
        return -1;
    }
}