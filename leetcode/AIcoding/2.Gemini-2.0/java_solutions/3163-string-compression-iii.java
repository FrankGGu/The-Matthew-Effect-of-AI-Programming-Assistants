class Solution {
    public int getLengthOfOptimalCompression(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                if (j > 0) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1]);
                }
                int del = 0, same = 0;
                for (int l = i; l >= 1; l--) {
                    if (s.charAt(l - 1) == s.charAt(i - 1)) {
                        same++;
                    } else {
                        del++;
                    }
                    if (j >= del) {
                        int len = 0;
                        if (same == 1) {
                            len = 1;
                        } else if (same < 10) {
                            len = 2;
                        } else if (same < 100) {
                            len = 3;
                        } else {
                            len = 4;
                        }

                        dp[i][j] = Math.min(dp[i][j], dp[l - 1][j - del] + (same == 1 ? 1 : (same < 10 ? 2 : (same < 100 ? 3 : 4))));
                    }
                }

                dp[i][j] = Math.min(dp[i][j], dp[i-1][j] + 1);
            }
        }

        return dp[n][k];
    }
}