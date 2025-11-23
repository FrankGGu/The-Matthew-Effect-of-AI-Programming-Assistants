class Solution {
    public int palindromePartition(String s, int k) {
        int n = s.length();
        int[][] cost = new int[n][n];
        for (int l = 2; l <= n; l++) {
            for (int i = 0, j = l - 1; j < n; i++, j++) {
                cost[i][j] = cost[i + 1][j - 1] + (s.charAt(i) == s.charAt(j) ? 0 : 1);
            }
        }

        int[][] dp = new int[k + 1][n];
        for (int i = 0; i < n; i++) {
            dp[1][i] = cost[0][i];
        }

        for (int kk = 2; kk <= k; kk++) {
            for (int end = kk - 1; end < n; end++) {
                dp[kk][end] = Integer.MAX_VALUE;
                for (int start = kk - 2; start < end; start++) {
                    dp[kk][end] = Math.min(dp[kk][end], dp[kk - 1][start] + cost[start + 1][end]);
                }
            }
        }

        return dp[k][n - 1];
    }
}