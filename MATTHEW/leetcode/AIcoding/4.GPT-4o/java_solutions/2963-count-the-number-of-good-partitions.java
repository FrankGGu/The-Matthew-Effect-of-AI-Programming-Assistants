class Solution {
    public int countGoodPartitions(String s) {
        int n = s.length();
        int mod = 1000000007;
        long[][] dp = new long[n + 1][n + 1];
        dp[0][0] = 1;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= i; j++) {
                dp[i + 1][j] = (dp[i + 1][j] + dp[i][j]) % mod;
                if (s.charAt(i) == '1') {
                    dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i][j]) % mod;
                }
            }
        }

        long ans = 0;
        for (int j = 0; j <= n; j++) {
            ans = (ans + dp[n][j]) % mod;
        }

        return (int) ans;
    }
}