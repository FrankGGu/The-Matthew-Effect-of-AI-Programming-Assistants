public class Solution {
    public int getMoneyAmount(int n) {
        if (n == 1) return 0;
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i < n; i++) {
            dp[i][i] = 0;
        }
        for (int length = 2; length <= n; length++) {
            for (int i = 1; i <= n - length + 1; i++) {
                int j = i + length - 1;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i; k <= j; k++) {
                    int cost = k + Math.max(dp[i][k - 1], dp[k + 1][j]);
                    dp[i][j] = Math.min(dp[i][j], cost);
                }
            }
        }
        return dp[1][n];
    }
}