class Solution {
    public int getLengthOfOptimalCompression(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                if (j > 0) {
                    dp[i][j] = dp[i - 1][j - 1];
                }
                int same = 0, diff = 0;
                for (int m = i; m >= 1; m--) {
                    if (s.charAt(m - 1) == s.charAt(i - 1)) {
                        same++;
                    } else {
                        diff++;
                    }
                    if (diff > j) {
                        break;
                    }
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
                    dp[i][j] = Math.min(dp[i][j], dp[m - 1][j - diff] + len);
                }
            }
        }
        return dp[n][k];
    }
}