class Solution {
    public int minimumChanges(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = Integer.MAX_VALUE / 2;
            }
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, k); j++) {
                for (int l = 0; l < i; l++) {
                    int changes = 0;
                    for (int m = 0; m < (i - l) / 2; m++) {
                        if (s.charAt(l + m) != s.charAt(i - 1 - m)) {
                            changes++;
                        }
                    }
                    dp[i][j] = Math.min(dp[i][j], dp[l][j - 1] + changes);
                }
            }
        }
        return dp[n][k];
    }
}