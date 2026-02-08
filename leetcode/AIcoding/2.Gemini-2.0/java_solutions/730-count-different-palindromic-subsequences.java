class Solution {
    private static final int MOD = 1000000007;

    public int countPalindromicSubsequences(String s) {
        int n = s.length();
        int[][] dp = new int[n][n];

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;

                if (i == j) {
                    dp[i][j] = 1;
                } else {
                    if (s.charAt(i) == s.charAt(j)) {
                        int low = i + 1;
                        int high = j - 1;

                        while (low <= high && s.charAt(low) != s.charAt(i)) {
                            low++;
                        }
                        while (low <= high && s.charAt(high) != s.charAt(i)) {
                            high--;
                        }

                        if (low > high) {
                            dp[i][j] = (2 * dp[i + 1][j - 1] + 2) % MOD;
                        } else if (low == high) {
                            dp[i][j] = (2 * dp[i + 1][j - 1] + 1) % MOD;
                        } else {
                            dp[i][j] = (2 * dp[i + 1][j - 1] - dp[low + 1][high - 1] + MOD) % MOD;
                        }
                    } else {
                        dp[i][j] = (dp[i][j - 1] + dp[i + 1][j] - dp[i + 1][j - 1] + MOD) % MOD;
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
}