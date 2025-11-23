int maxDisjointSubstring(char * s, int k) {
    int n = strlen(s);
    int dp[n + 1][k + 1];
    memset(dp, 0, sizeof(dp));

    int last[26] = {-1};
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < 26; j++) {
            last[j] = -1;
        }
        int uniqueCount = 0;
        for (int j = i; j >= 1; j--) {
            if (last[s[j - 1] - 'a'] == -1) {
                uniqueCount++;
            }
            last[s[j - 1] - 'a'] = j - 1;
            if (uniqueCount > k) break;

            for (int l = 1; l <= k; l++) {
                dp[i][l] = fmax(dp[i][l], dp[j - 1][l - 1] + uniqueCount);
            }
        }
    }

    return dp[n][k];
}