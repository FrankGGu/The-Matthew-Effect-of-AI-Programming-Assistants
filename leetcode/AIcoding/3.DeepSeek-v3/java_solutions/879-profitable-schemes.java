class Solution {
    public int profitableSchemes(int n, int minProfit, int[] group, int[] profit) {
        int MOD = 1000000007;
        int[][][] dp = new int[group.length + 1][n + 1][minProfit + 1];
        dp[0][0][0] = 1;

        for (int i = 1; i <= group.length; i++) {
            int members = group[i - 1];
            int earn = profit[i - 1];
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k <= minProfit; k++) {
                    dp[i][j][k] = dp[i - 1][j][k];
                    if (j >= members) {
                        dp[i][j][k] += dp[i - 1][j - members][Math.max(0, k - earn)];
                        dp[i][j][k] %= MOD;
                    }
                }
            }
        }

        int total = 0;
        for (int j = 0; j <= n; j++) {
            total += dp[group.length][j][minProfit];
            total %= MOD;
        }
        return total;
    }
}