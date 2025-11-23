class Solution {
    private static final int MOD = 1_000_000_007;

    public int numberOfCombinations(String num) {
        int n = num.length();
        if (n == 0 || num.charAt(0) == '0') {
            return 0;
        }

        int[][] lcp = new int[n + 1][n + 1];
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (num.charAt(i) == num.charAt(j)) {
                    lcp[i][j] = lcp[i + 1][j + 1] + 1;
                }
            }
        }

        int[][] dp = new int[n][n];
        for (int i = 0; i < n; ++i) {
            dp[0][i] = 1;
        }

        for (int i = 1; i < n; ++i) {
            if (num.charAt(i) == '0') {
                continue;
            }
            for (int j = i; j < n; ++j) {
                int len = j - i + 1;
                int prevStart = i - 1 - (len - 1);
                int count = 0;
                if (prevStart < 0) {
                    count = dp[i - 1][i - 1];
                } else {
                    int maxLen = lcp[prevStart][i];
                    if (maxLen >= len || num.charAt(prevStart + maxLen) < num.charAt(i + maxLen)) {
                        count = (dp[i - 1][i - 1] - (prevStart == 0 ? 0 : dp[prevStart - 1][i - 1]) + MOD) % MOD;
                    } else {
                        count = (dp[i - 1][i - 1] - (prevStart == 0 ? 0 : dp[prevStart - 1][i - 1]) + MOD) % MOD;
                        if (prevStart > 0) {
                            count = (count + dp[prevStart - 1][prevStart + len - 1]) % MOD;
                        }
                    }
                }
                dp[i][j] = (dp[i - 1][j] + count) % MOD;
            }
        }

        return dp[n - 1][n - 1];
    }
}