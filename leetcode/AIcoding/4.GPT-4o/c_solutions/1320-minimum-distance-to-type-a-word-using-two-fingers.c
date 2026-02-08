int minimumDistance(char *word) {
    int dp[26][26] = {0};
    int n = strlen(word);

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            dp[i][j] = abs(i / 6 - j / 6) + abs(i % 6 - j % 6);
        }
    }

    int dp2[n + 1][n + 1];
    memset(dp2, 0x3f, sizeof(dp2));
    dp2[0][0] = 0;

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            if (i < n) {
                dp2[i + 1][j] = fmin(dp2[i + 1][j], dp2[i][j] + (j == 0 ? 0 : dp[word[i] - 'a'][word[j] - 'a']));
            }
            if (j < n) {
                dp2[i][j + 1] = fmin(dp2[i][j + 1], dp2[i][j] + (i == 0 ? 0 : dp[word[i] - 'a'][word[j] - 'a']));
            }
        }
    }

    return dp2[n][n];
}