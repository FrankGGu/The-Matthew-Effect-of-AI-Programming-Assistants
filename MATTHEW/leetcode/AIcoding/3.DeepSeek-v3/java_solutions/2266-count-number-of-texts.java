class Solution {
    public int countTexts(String pressedKeys) {
        int mod = 1000000007;
        int n = pressedKeys.length();
        long[] dp = new long[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            char c = pressedKeys.charAt(i - 1);
            dp[i] = dp[i - 1];
            if (i >= 2 && pressedKeys.charAt(i - 2) == c) {
                dp[i] += dp[i - 2];
                dp[i] %= mod;
                if (i >= 3 && pressedKeys.charAt(i - 3) == c) {
                    dp[i] += dp[i - 3];
                    dp[i] %= mod;
                    if ((c == '7' || c == '9') && i >= 4 && pressedKeys.charAt(i - 4) == c) {
                        dp[i] += dp[i - 4];
                        dp[i] %= mod;
                    }
                }
            }
        }

        return (int) (dp[n] % mod);
    }
}