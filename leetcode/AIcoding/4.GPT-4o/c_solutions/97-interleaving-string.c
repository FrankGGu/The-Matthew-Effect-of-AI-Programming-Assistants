bool isInterleave(char *s1, char *s2, char *s3) {
    int len1 = strlen(s1), len2 = strlen(s2), len3 = strlen(s3);
    if (len1 + len2 != len3) return false;

    bool dp[len2 + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = true;

    for (int j = 1; j <= len2; j++) {
        dp[j] = dp[j - 1] && (s2[j - 1] == s3[j - 1]);
    }

    for (int i = 1; i <= len1; i++) {
        dp[0] = dp[0] && (s1[i - 1] == s3[i - 1]);
        for (int j = 1; j <= len2; j++) {
            dp[j] = (dp[j] && (s1[i - 1] == s3[i + j - 1])) || (dp[j - 1] && (s2[j - 1] == s3[i + j - 1]));
        }
    }

    return dp[len2];
}