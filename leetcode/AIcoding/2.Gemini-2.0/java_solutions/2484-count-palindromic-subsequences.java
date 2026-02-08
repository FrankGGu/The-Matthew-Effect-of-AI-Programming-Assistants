class Solution {
    public int countPalindromicSubsequences(String s) {
        int n = s.length();
        int mod = 1000000007;
        int[][][] dp = new int[n][n][4];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 4; j++) {
                if (s.charAt(i) - 'a' == j) {
                    dp[i][i][j] = 1;
                }
            }
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                for (int k = 0; k < 4; k++) {
                    if (s.charAt(i) - 'a' == k && s.charAt(j) - 'a' == k) {
                        dp[i][j][k] = 2;
                        for (int l = 0; l < 4; l++) {
                            dp[i][j][k] = (dp[i][j][k] + dp[i + 1][j - 1][l]) % mod;
                        }
                    } else if (s.charAt(i) - 'a' == k) {
                        dp[i][j][k] = dp[i][j - 1][k];
                    } else if (s.charAt(j) - 'a' == k) {
                        dp[i][j][k] = dp[i + 1][j][k];
                    } else {
                        dp[i][j][k] = dp[i + 1][j - 1][k];
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < 4; i++) {
            ans = (ans + dp[0][n - 1][i]) % mod;
        }
        return ans;
    }
}