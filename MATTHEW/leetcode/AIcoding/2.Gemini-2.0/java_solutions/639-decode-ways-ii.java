class Solution {
    private static final int MOD = 1000000007;

    public int numDecodings(String s) {
        int n = s.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;
        dp[1] = (s.charAt(0) == '0') ? 0 : (s.charAt(0) == '*') ? 9 : 1;

        for (int i = 2; i <= n; i++) {
            char c1 = s.charAt(i - 1);
            char c2 = s.charAt(i - 2);

            if (c1 == '*') {
                dp[i] = (dp[i] + 9 * dp[i - 1]) % MOD;
            } else if (c1 != '0') {
                dp[i] = (dp[i] + dp[i - 1]) % MOD;
            }

            if (c2 == '*') {
                if (c1 == '*') {
                    dp[i] = (dp[i] + 15 * dp[i - 2]) % MOD;
                } else if (c1 >= '0' && c1 <= '6') {
                    dp[i] = (dp[i] + 2 * dp[i - 2]) % MOD;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            } else if (c2 == '1') {
                if (c1 == '*') {
                    dp[i] = (dp[i] + 9 * dp[i - 2]) % MOD;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            } else if (c2 == '2') {
                if (c1 == '*') {
                    dp[i] = (dp[i] + 6 * dp[i - 2]) % MOD;
                } else if (c1 >= '0' && c1 <= '6') {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            }
        }

        return (int) dp[n];
    }
}