class Solution {
    private static final int MOD = 1000000007;
    private int n;
    private String s;
    private int[][] dp;
    private int[][] lcp;

    public int numberOfWays(String s) {
        this.s = s;
        this.n = s.length();
        this.dp = new int[n][n];
        this.lcp = new int[n + 1][n + 1];

        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (s.charAt(i) == s.charAt(j)) {
                    lcp[i][j] = lcp[i + 1][j + 1] + 1;
                } else {
                    lcp[i][j] = 0;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (s.charAt(0) != '0') {
                dp[0][i] = 1;
            }
        }

        for (int i = 1; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (s.charAt(i) == '0') {
                    dp[i][j] = 0;
                    continue;
                }

                for (int k = i; k <= j; k++) {
                    int len = i;
                    int prevLen = k - i + 1;

                    if (i - len >= 0) {
                        int common = lcp[i - len][i];
                        if (common >= len || s.charAt(i - len + common) < s.charAt(i + common)) {
                            dp[i][j] = (dp[i][j] + dp[i - len][i - 1]) % MOD;
                        } else if (common < len) {
                            if (len < prevLen)
                                dp[i][j] = (dp[i][j] + dp[i - len][i - 1]) % MOD;
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < n; i++) {
            ans = (ans + dp[i][n - 1]) % MOD;
        }

        return ans;
    }
}