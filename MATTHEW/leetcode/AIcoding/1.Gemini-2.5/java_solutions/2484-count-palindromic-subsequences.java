class Solution {
    public int countPalindromicSubsequences(String s) {
        int N = s.length();
        long[][] dp = new long[N][N];
        int MOD = 1_000_000_007;

        for (int i = 0; i < N; i++) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= N; len++) {
            for (int i = 0; i <= N - len; i++) {
                int j = i + len - 1;

                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = (dp[i + 1][j] + dp[i][j - 1] + 1) % MOD;
                } else {
                    dp[i][j] = (dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1] + MOD) % MOD;
                }
            }
        }

        return (int) dp[0][N - 1];
    }
}