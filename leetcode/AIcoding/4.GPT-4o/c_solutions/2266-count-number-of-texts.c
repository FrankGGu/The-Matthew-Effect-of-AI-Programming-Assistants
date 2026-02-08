int countTexts(char * pressedKeys) {
    long long dp[100001] = {1};
    int n = strlen(pressedKeys);

    for (int i = 1; i <= n; i++) {
        int currentKey = pressedKeys[i - 1] - '0';
        dp[i] = dp[i - 1];

        if (i > 1 && pressedKeys[i - 1] == pressedKeys[i - 2]) {
            dp[i] = (dp[i] + dp[i - 2]) % 1000000007;
        }
        if (i > 2 && pressedKeys[i - 1] == pressedKeys[i - 2] && pressedKeys[i - 2] == pressedKeys[i - 3]) {
            dp[i] = (dp[i] + dp[i - 3]) % 1000000007;
        }
        if (i > 3 && pressedKeys[i - 1] == pressedKeys[i - 2] && pressedKeys[i - 2] == pressedKeys[i - 3] && pressedKeys[i - 3] == pressedKeys[i - 4]) {
            dp[i] = (dp[i] + dp[i - 4]) % 1000000007;
        }
    }

    return dp[n];
}