class Solution {
    public int profitableSchemes(int n, int minProfit, int[] group, int[] profit) {
        int len = group.length;
        int MOD = 1000000007;
        int[][][] dp = new int[len + 1][n + 1][minProfit + 1];
        dp[0][0][0] = 1;

        for (int i = 1; i <= len; i++) {
            int g = group[i - 1];
            int p = profit[i - 1];
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k <= minProfit; k++) {
                    dp[i][j][k] = dp[i - 1][j][k];
                    if (j >= g) {
                        dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j - g][Math.max(0, k - p)]) % MOD;
                    }
                }
            }
        }

        int total = 0;
        for (int j = 0; j <= n; j++) {
            total = (total + dp[len][j][minProfit]) % MOD;
        }
        return total;
    }
}