class Solution {
    public int strangePrinter(String s) {
        int n = s.length();
        if (n == 0) return 0;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                dp[i][j] = len;
                for (int k = i; k < j; k++) {
                    int total = dp[i][k] + dp[k + 1][j];
                    if (s.charAt(k) == s.charAt(j)) {
                        total--;
                    }
                    dp[i][j] = Math.min(dp[i][j], total);
                }
            }
        }
        return dp[0][n - 1];
    }
}