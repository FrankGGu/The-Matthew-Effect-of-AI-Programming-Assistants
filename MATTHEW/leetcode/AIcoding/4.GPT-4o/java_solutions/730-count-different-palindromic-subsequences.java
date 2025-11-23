class Solution {
    public int countPalindromicSubsequences(String s) {
        int n = s.length();
        int[][] dp = new int[n][n];

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (i == j) {
                    dp[i][j] = 1;
                } else if (s.charAt(i) == s.charAt(j)) {
                    int l = i + 1, r = j - 1;
                    while (l <= r && s.charAt(l) != s.charAt(i)) l++;
                    while (l <= r && s.charAt(r) != s.charAt(i)) r--;
                    if (l > r) {
                        dp[i][j] = dp[i + 1][j - 1] + 2;
                    } else if (l == r) {
                        dp[i][j] = dp[i + 1][j - 1] + 1;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] - dp[l + 1][r - 1] + 2;
                    }
                } else {
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                }
            }
        }
        return dp[0][n - 1];
    }
}