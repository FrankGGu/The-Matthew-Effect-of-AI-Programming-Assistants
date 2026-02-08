class Solution {
    public int numberOfWays(int k, int[][] types) {
        int MOD = 1000000007;
        int n = types.length;
        int[][] dp = new int[n + 1][k + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            int count = types[i - 1][0];
            int points = types[i - 1][1];

            for (int j = 0; j <= k; j++) {
                for (int x = 0; x <= count; x++) {
                    if (j - x * points >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - x * points]) % MOD;
                    }
                }
            }
        }

        return dp[n][k];
    }
}