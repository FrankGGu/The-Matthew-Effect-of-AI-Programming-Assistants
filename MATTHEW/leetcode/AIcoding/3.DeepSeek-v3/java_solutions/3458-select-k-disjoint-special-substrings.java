class Solution {
    public int maxDisjointSpecialSubstrings(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], -1);
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= k; j++) {
                if (dp[i][j] == -1) continue;
                for (int l = i + 1; l <= n; l++) {
                    if (isSpecial(s.substring(i, l))) {
                        if (j + 1 <= k) {
                            if (dp[l][j + 1] < dp[i][j] + (l - i)) {
                                dp[l][j + 1] = dp[i][j] + (l - i);
                            }
                        }
                    }
                }
            }
        }

        int max = -1;
        for (int i = 0; i <= n; i++) {
            if (dp[i][k] > max) {
                max = dp[i][k];
            }
        }
        return max;
    }

    private boolean isSpecial(String s) {
        int n = s.length();
        if (n == 1) return true;
        if (s.charAt(0) == s.charAt(n - 1)) {
            return false;
        }
        return true;
    }
}