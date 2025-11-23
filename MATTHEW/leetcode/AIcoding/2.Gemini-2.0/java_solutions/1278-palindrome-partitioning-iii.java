class Solution {
    public int palindromePartition(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        int[][] cost = new int[n][n];

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s.charAt(i) == s.charAt(j)) {
                    cost[i][j] = (len == 2) ? 0 : cost[i + 1][j - 1];
                } else {
                    cost[i][j] = 1 + ((len == 2) ? 0 : cost[i + 1][j - 1]);
                }
            }
        }

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = (int) 1e9;
            }
        }

        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                for (int l = 1; l <= i; l++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - l][j - 1] + cost[i - l][i - 1]);
                }
            }
        }

        return dp[n][k];
    }
}