class Solution {
    public int countTexts(String pressedKeys) {
        int MOD = 1_000_000_007;
        int n = pressedKeys.length();
        int[] dp = new int[n + 1];
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            char currentDigit = pressedKeys.charAt(i - 1);

            // Option 1: Take the last digit alone
            dp[i] = dp[i - 1];

            // Option 2: Take the last two digits if they are the same
            if (i >= 2 && pressedKeys.charAt(i - 2) == currentDigit) {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;

                // Option 3: Take the last three digits if they are the same
                if (i >= 3 && pressedKeys.charAt(i - 3) == currentDigit) {
                    dp[i] = (dp[i] + dp[i - 3]) % MOD;

                    // Option 4: Take the last four digits if they are the same and currentDigit is '7' or '9'
                    if ((currentDigit == '7' || currentDigit == '9') && i >= 4 && pressedKeys.charAt(i - 4) == currentDigit) {
                        dp[i] = (dp[i] + dp[i - 4]) % MOD;
                    }
                }
            }
        }

        return dp[n];
    }
}