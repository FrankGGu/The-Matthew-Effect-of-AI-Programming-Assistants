class Solution {
    public int maxPalindromes(String s, int k) {
        int n = s.length();

        int[] dp = new int[n + 1];
        boolean[][] isPal = new boolean[n][n];

        for (int len = 1; len <= n; len++) {
            for (int j = 0; j <= n - len; j++) {
                int i = j + len - 1;
                if (len == 1) {
                    isPal[j][i] = true;
                } else if (len == 2) {
                    isPal[j][i] = (s.charAt(j) == s.charAt(i));
                } else {
                    isPal[j][i] = (s.charAt(j) == s.charAt(i)) && isPal[j + 1][i - 1];
                }
            }
        }

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];

            for (int j = 0; j < i; j++) {
                if (isPal[j][i - 1] && (i - j) >= k) {
                    dp[i] = Math.max(dp[i], (j > 0 ? dp[j] : 0) + 1);
                }
            }
        }

        return dp[n];
    }
}