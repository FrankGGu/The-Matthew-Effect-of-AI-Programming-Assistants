class Solution {
    public int numDecodings(String s) {
        long mod = 1000000007;
        int n = s.length();
        if (n == 0) return 0;

        long[] dp = new long[n + 1];
        dp[0] = 1;
        dp[1] = s.charAt(0) == '0' ? 0 : s.charAt(0) == '*' ? 9 : 1;

        for (int i = 2; i <= n; i++) {
            char curr = s.charAt(i - 1);
            char prev = s.charAt(i - 2);

            if (curr == '*') {
                dp[i] = (dp[i] + dp[i - 1] * 9) % mod;
            } else if (curr != '0') {
                dp[i] = (dp[i] + dp[i - 1]) % mod;
            }

            if (prev == '1') {
                dp[i] = (dp[i] + dp[i - 2]) % mod;
            } else if (prev == '2') {
                dp[i] = (dp[i] + dp[i - 2] * (curr <= '6' ? 1 : 0)) % mod;
            } else if (prev == '*') {
                dp[i] = (dp[i] + dp[i - 2] * (curr <= '6' ? 2 : 1)) % mod;
            }
        }

        return (int) dp[n];
    }
}