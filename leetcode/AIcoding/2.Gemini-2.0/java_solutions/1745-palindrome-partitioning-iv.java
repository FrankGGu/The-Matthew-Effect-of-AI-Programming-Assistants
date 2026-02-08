class Solution {
    public boolean checkPartitioning(String s) {
        int n = s.length();
        boolean[][] dp = new boolean[n][n];
        for (int i = n - 1; i >= 0; i--) {
            for (int j = i; j < n; j++) {
                if (s.charAt(i) == s.charAt(j) && (j - i <= 2 || dp[i + 1][j - 1])) {
                    dp[i][j] = true;
                }
            }
        }

        for (int i = 1; i < n - 1; i++) {
            if (dp[0][i - 1]) {
                for (int j = i + 1; j < n; j++) {
                    if (dp[i][j - 1] && dp[j][n - 1]) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}