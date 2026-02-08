class Solution {
    public int maxPalindrome(String word1, String word2) {
        String s = word1 + word2;
        int n1 = word1.length();
        int n2 = word2.length();
        int n = s.length();
        int[][] dp = new int[n][n];
        int ans = 0;

        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                    if (i < n1 && j >= n1) {
                        ans = Math.max(ans, dp[i][j]);
                    }
                } else {
                    dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        return ans;
    }
}