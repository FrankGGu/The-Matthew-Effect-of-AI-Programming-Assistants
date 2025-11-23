public class Solution {
    public int numMusicPlaylists(int n, int k, int l) {
        long[][] dp = new long[l + 1][n + 1];
        dp[0][0] = 1;
        for (int i = 1; i <= l; ++i) {
            for (int j = 0; j <= n; ++j) {
                if (j > 0) {
                    dp[i][j] += dp[i - 1][j - 1] * (n - j + 1);
                }
                if (i > k) {
                    dp[i][j] += dp[i - 1][j] * Math.max(0, j - k);
                }
                dp[i][j] %= 1_000_000_007;
            }
        }
        return (int) dp[l][n];
    }
}