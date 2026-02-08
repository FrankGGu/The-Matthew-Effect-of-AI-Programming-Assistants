class Solution {
    public int palindromicPartition(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n][n];
        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (len == 1) {
                    dp[i][j] = 0;
                } else if (len == 2) {
                    dp[i][j] = (s.charAt(i) == s.charAt(j)) ? 0 : 1;
                } else {
                    dp[i][j] = (s.charAt(i) == s.charAt(j)) ? dp[i + 1][j - 1] : dp[i + 1][j - 1] + 1;
                }
            }
        }

        int[][] cuts = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                cuts[i][j] = Integer.MAX_VALUE / 2;
            }
        }
        cuts[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, k); j++) {
                for (int p = 0; p < i; p++) {
                    cuts[i][j] = Math.min(cuts[i][j], cuts[p][j - 1] + dp[p][i - 1]);
                }
            }
        }

        return cuts[n][k];
    }
}