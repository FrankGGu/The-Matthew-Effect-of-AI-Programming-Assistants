class Solution {
    public int countArrays(int n, int k) {
        int mod = 1000000007;
        long[][] dp = new long[n + 1][k + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = (dp[i - 1][j - 1] + (dp[i - 1][j] * (j + 1)) % mod) % mod;
            }
        }

        long result = 0;
        for (int j = 1; j <= k; j++) {
            result = (result + dp[n][j]) % mod;
        }

        return (int) result;
    }
}