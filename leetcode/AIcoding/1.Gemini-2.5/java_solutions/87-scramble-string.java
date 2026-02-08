class Solution {
    public boolean isScramble(String s1, String s2) {
        if (s1.length() != s2.length()) {
            return false;
        }
        if (s1.equals(s2)) {
            return true;
        }

        int n = s1.length();
        boolean[][][] dp = new boolean[n][n][n + 1];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j][1] = (s1.charAt(i) == s2.charAt(j));
            }
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                for (int j = 0; j <= n - len; j++) {
                    for (int k = 1; k < len; k++) {
                        // Case 1: No swap
                        // s1[i...i+k-1] scramble of s2[j...j+k-1]
                        // AND s1[i+k...i+len-1] scramble of s2[j+k...j+len-1]
                        if (dp[i][j][k] && dp[i + k][j + k][len - k]) {
                            dp[i][j][len] = true;
                            break;
                        }

                        // Case 2: Swap
                        // s1[i...i+k-1] scramble of s2[j+len-k...j+len-1]
                        // AND s1[i+k...i+len-1] scramble of s2[j...j+len-k-1]
                        if (dp[i][j + len - k][k] && dp[i + k][j][len - k]) {
                            dp[i][j][len] = true;
                            break;
                        }
                    }
                }
            }
        }

        return dp[0][0][n];
    }
}