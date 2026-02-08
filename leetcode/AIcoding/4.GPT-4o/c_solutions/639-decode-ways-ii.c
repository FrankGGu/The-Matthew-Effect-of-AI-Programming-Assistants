int numDecodings(char * s) {
    long long dp[10001] = {0};
    dp[0] = 1;
    dp[1] = s[0] == '0' ? 0 : 1;

    for (int i = 2; s[i - 1] != '\0'; i++) {
        if (s[i - 1] == '0') {
            dp[i] = dp[i - 1] * (s[i - 2] == '1' || s[i - 2] == '2' ? 1 : 0);
        } else {
            dp[i] = dp[i - 1];
            if (s[i - 2] == '1' || (s[i - 2] == '2' && s[i - 1] <= '6')) {
                dp[i] += dp[i - 2];
            }
        }
        if (s[i - 1] == '*') {
            dp[i] = (dp[i] * 9) % 1000000007;
            if (s[i - 2] == '1') {
                dp[i] = (dp[i] + dp[i - 2]) % 1000000007;
            } else if (s[i - 2] == '2') {
                dp[i] = (dp[i] + dp[i - 2]) % 1000000007;
            } else if (s[i - 2] == '*') {
                dp[i] = (dp[i] + dp[i - 2] * 6) % 1000000007;
            }
        }
        dp[i] %= 1000000007;
    }
    return dp[strlen(s)];
}