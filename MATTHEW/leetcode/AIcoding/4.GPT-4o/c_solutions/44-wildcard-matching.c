bool isMatch(char * s, char * p) {
    int sLen = strlen(s);
    int pLen = strlen(p);

    bool dp[sLen + 1][pLen + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = true;

    for (int j = 1; j <= pLen; j++) {
        if (p[j - 1] == '*') {
            dp[0][j] = dp[0][j - 1];
        }
    }

    for (int i = 1; i <= sLen; i++) {
        for (int j = 1; j <= pLen; j++) {
            if (p[j - 1] == '*') {
                dp[i][j] = dp[i][j - 1] || dp[i - 1][j];
            } else if (p[j - 1] == '?' || s[i - 1] == p[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            }
        }
    }

    return dp[sLen][pLen];
}