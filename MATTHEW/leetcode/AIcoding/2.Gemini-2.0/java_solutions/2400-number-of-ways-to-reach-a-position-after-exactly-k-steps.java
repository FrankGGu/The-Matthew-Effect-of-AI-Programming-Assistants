class Solution {
    private static final int MOD = 1000000007;

    public int numberOfWays(int startPos, int endPos, int k) {
        int diff = Math.abs(startPos - endPos);
        if (diff > k) {
            return 0;
        }

        if ((k - diff) % 2 != 0) {
            return 0;
        }

        int[][] dp = new int[k + 1][2 * k + 1];
        dp[0][k] = 1;

        for (int i = 1; i <= k; i++) {
            for (int j = 0; j <= 2 * k; j++) {
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                }
                if (j < 2 * k) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
                }
            }
        }

        return dp[k][diff + k];
    }
}