int minExtraChar(char* s, char** dictionary, int dictionarySize) {
    int n = strlen(s);
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = i;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < dictionarySize; j++) {
            int len = strlen(dictionary[j]);
            if (i >= len && strncmp(s + i - len, dictionary[j], len) == 0) {
                if (dp[i - len] < dp[i]) {
                    dp[i] = dp[i - len];
                }
            }
        }
        if (dp[i - 1] + 1 < dp[i]) {
            dp[i] = dp[i - 1] + 1;
        }
    }

    return dp[n];
}