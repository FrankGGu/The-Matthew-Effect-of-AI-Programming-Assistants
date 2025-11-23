class Solution {
    private static final int MOD = 1000000007;

    public int numDecodings(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }
        int n = s.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;
        dp[1] = ways(s.charAt(0));

        for (int i = 2; i <= n; i++) {
            char c1 = s.charAt(i - 2);
            char c2 = s.charAt(i - 1);
            dp[i] = (dp[i - 1] * ways(c2) + dp[i - 2] * ways(c1, c2)) % MOD;
        }

        return (int) dp[n];
    }

    private int ways(char c) {
        if (c == '0') {
            return 0;
        }
        if (c == '*') {
            return 9;
        }
        return 1;
    }

    private int ways(char c1, char c2) {
        if (c1 == '*' && c2 == '*') {
            return 15;
        }
        if (c1 == '*') {
            if (c2 >= '0' && c2 <= '6') {
                return 2;
            } else {
                return 1;
            }
        }
        if (c2 == '*') {
            if (c1 == '1') {
                return 9;
            } else if (c1 == '2') {
                return 6;
            } else {
                return 0;
            }
        }
        int num = (c1 - '0') * 10 + (c2 - '0');
        if (num >= 10 && num <= 26) {
            return 1;
        }
        return 0;
    }
}