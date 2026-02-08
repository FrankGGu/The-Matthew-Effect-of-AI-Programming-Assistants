class Solution {
    public int longestPalindrome(String word1, String word2) {
        String s = word1 + word2;
        int n1 = word1.length();
        int n = s.length();

        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = 2 + dp[i+1][j-1]; 
                } else {
                    dp[i][j] = Math.max(dp[i+1][j], dp[i][j-1]);
                }
            }
        }

        int maxLen = 0;
        for (int i = 0; i < n1; i++) {
            for (int j = n1; j < n; j++) {
                if (s.charAt(i) == s.charAt(j)) {
                    maxLen = Math.max(maxLen, dp[i][j]);
                }
            }
        }

        return maxLen;
    }
}