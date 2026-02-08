class Solution {
    public int maxPalindromes(String s, int k) {
        int n = s.length();
        boolean[][] dp = new boolean[n][n];
        for (int i = 0; i < n; i++) {
            dp[i][i] = true;
        }
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = (len == 2) || dp[i + 1][j - 1];
                }
            }
        }

        int[] dpCount = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dpCount[i] = dpCount[i - 1];
            for (int j = i - k; j >= 0; j--) {
                if (dp[j][i - 1]) {
                    dpCount[i] = Math.max(dpCount[i], dpCount[j] + 1);
                }
            }
        }
        return dpCount[n];
    }
}