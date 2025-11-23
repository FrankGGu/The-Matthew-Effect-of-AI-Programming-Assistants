class Solution {
    private static final int MOD = 1000000007;

    public int numOfArrays(int n, int m, int k) {
        if (k > m) {
            return 0;
        }

        int[][][] dp = new int[n + 1][k + 1][m + 1];
        int[][][] prefixSum = new int[n + 1][k + 1][m + 2];

        for (int j = 1; j <= m; j++) {
            dp[1][1][j] = 1;
            prefixSum[1][1][j + 1] = (prefixSum[1][1][j] + dp[1][1][j]) % MOD;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                for (int l = 1; l <= m; l++) {
                    dp[i][j][l] = (int) (((long) dp[i - 1][j][l] * l) % MOD);
                    dp[i][j][l] = (dp[i][j][l] + prefixSum[i - 1][j - 1][l]) % MOD;
                }

                for (int l = 1; l <= m; l++) {
                    prefixSum[i][j][l + 1] = (prefixSum[i][j][l] + dp[i][j][l]) % MOD;
                }
            }
        }

        return prefixSum[n][k][m + 1];
    }
}