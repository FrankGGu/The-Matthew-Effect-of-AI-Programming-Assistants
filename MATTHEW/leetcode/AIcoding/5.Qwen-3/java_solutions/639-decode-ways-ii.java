public class Solution {
    public int numDecodings(String s) {
        int n = s.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;
        dp[1] = s.charAt(0) == '*' ? 9 : (s.charAt(0) == '0' ? 0 : 1);

        for (int i = 2; i <= n; i++) {
            char c = s.charAt(i - 1);
            char prev = s.charAt(i - 2);

            if (c == '*') {
                dp[i] += dp[i - 1] * 9;
            } else if (c != '0') {
                dp[i] += dp[i - 1];
            }

            if (prev == '*') {
                if (c == '*') {
                    dp[i] += dp[i - 2] * 15;
                } else {
                    dp[i] += dp[i - 2] * (c <= '6' ? 2 : 1);
                }
            } else if (prev == '1') {
                dp[i] += dp[i - 2];
            } else if (prev == '2' && c <= '6') {
                dp[i] += dp[i - 2];
            } else if (prev == '0') {
                dp[i] += 0;
            }

            dp[i] %= 1000000007;
        }

        return (int) dp[n];
    }
}