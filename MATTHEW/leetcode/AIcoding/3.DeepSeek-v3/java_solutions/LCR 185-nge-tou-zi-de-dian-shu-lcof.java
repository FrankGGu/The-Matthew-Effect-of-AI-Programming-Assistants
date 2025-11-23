class Solution {
    public double[] dicesProbability(int n) {
        int[][] dp = new int[n + 1][6 * n + 1];
        for (int i = 1; i <= 6; i++) {
            dp[1][i] = 1;
        }
        for (int i = 2; i <= n; i++) {
            for (int j = i; j <= 6 * i; j++) {
                for (int k = 1; k <= 6; k++) {
                    if (j - k >= 0) {
                        dp[i][j] += dp[i - 1][j - k];
                    }
                }
            }
        }
        double total = Math.pow(6, n);
        double[] res = new double[5 * n + 1];
        for (int i = 0; i < res.length; i++) {
            res[i] = dp[n][n + i] / total;
        }
        return res;
    }
}