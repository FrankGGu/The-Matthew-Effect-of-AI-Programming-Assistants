class Solution {
    public int minCost(int n, int k) {
        if (k > n) {
            return n;
        }
        if (k == 1) {
            return n;
        }

        int[][] dp = new int[n + 1][k + 1];
        for (int i = 1; i <= n; i++) {
            dp[i][1] = i;
        }
        for (int j = 1; j <= k; j++) {
            dp[1][j] = 1;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 2; j <= k; j++) {
                if (j > i) {
                    dp[i][j] = dp[i][i];
                } else {
                    dp[i][j] = Math.min(dp[i - 1][j] + 1, dp[i - 1][j - 1] + 1);
                }
            }
        }

        return dp[n][k];
    }
}