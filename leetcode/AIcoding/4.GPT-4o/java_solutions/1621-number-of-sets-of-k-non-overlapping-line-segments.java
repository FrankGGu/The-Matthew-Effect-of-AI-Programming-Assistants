class Solution {
    public int numberOfSets(int n, int k) {
        int MOD = 1000000007;
        long[][] dp = new long[k + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            dp[0][i] = 1;
        }
        for (int i = 1; i <= k; i++) {
            for (int j = i; j <= n; j++) {
                dp[i][j] = (dp[i][j - 1] + dp[i - 1][j - 1] * (j - i + 1)) % MOD;
            }
        }
        return (int) dp[k][n];
    }
}