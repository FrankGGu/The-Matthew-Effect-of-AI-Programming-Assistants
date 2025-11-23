public class Solution {
    public int countDifferentPalindromicSubsequences(int n, String s) {
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = dp[i + 1][j - 1] * 2;
                    if (s.charAt(i + 1) == s.charAt(j - 1)) {
                        dp[i][j] += 2;
                    } else if (s.charAt(i + 1) != s.charAt(j - 1)) {
                        dp[i][j] -= dp[i + 1][j - 1];
                    }
                } else {
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                }
                if (dp[i][j] < 0) {
                    dp[i][j] += 1000000007;
                }
            }
        }
        return dp[0][n - 1];
    }
}