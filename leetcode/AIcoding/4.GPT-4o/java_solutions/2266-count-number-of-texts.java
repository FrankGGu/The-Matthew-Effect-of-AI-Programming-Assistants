class Solution {
    public int countTexts(String pressedKeys) {
        int mod = 1000000007;
        int n = pressedKeys.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            char c = pressedKeys.charAt(i - 1);
            dp[i] = (dp[i - 1]) % mod;

            if (c == '7' || c == '9') {
                if (i > 1 && pressedKeys.charAt(i - 2) == c) {
                    dp[i] = (dp[i] + dp[i - 2]) % mod;
                }
                if (i > 2 && pressedKeys.charAt(i - 2) == c && pressedKeys.charAt(i - 3) == c) {
                    dp[i] = (dp[i] + dp[i - 3]) % mod;
                }
            } else {
                if (i > 1 && pressedKeys.charAt(i - 2) == c) {
                    dp[i] = (dp[i] + dp[i - 2]) % mod;
                }
            }
        }
        return (int) dp[n];
    }
}