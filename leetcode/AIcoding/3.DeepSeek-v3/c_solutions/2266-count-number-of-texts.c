int countTexts(char* pressedKeys) {
    int mod = 1000000007;
    int n = strlen(pressedKeys);
    long long dp[n + 1];
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        char c = pressedKeys[i - 1];

        if (i >= 2 && pressedKeys[i - 2] == c) {
            dp[i] = (dp[i] + dp[i - 2]) % mod;
            if (i >= 3 && pressedKeys[i - 3] == c) {
                dp[i] = (dp[i] + dp[i - 3]) % mod;
                if ((c == '7' || c == '9') && i >= 4 && pressedKeys[i - 4] == c) {
                    dp[i] = (dp[i] + dp[i - 4]) % mod;
                }
            }
        }
    }

    return dp[n];
}