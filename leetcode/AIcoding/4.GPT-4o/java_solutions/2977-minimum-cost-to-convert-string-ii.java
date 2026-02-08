class Solution {
    public int minimumCost(String s1, String s2) {
        int n = s1.length();
        int[][] dp = new int[n + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i][0] = dp[i - 1][0] + 1; // cost of deleting s1[i-1]
            dp[0][i] = dp[0][i - 1] + 1; // cost of deleting s2[i-1]
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if (s1.charAt(i - 1) == s2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = Math.min(dp[i - 1][j] + 1, Math.min(dp[i][j - 1] + 1, dp[i - 1][j - 1] + 1));
                }
            }
        }

        return dp[n][n];
    }
}