int longestIdealString(char* s, int k) {
    int dp[26] = {0};
    int maxLen = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        int curr = s[i] - 'a';
        int best = 0;

        for (int j = 0; j < 26; j++) {
            if (abs(j - curr) <= k) {
                if (dp[j] > best) {
                    best = dp[j];
                }
            }
        }

        dp[curr] = best + 1;
        if (dp[curr] > maxLen) {
            maxLen = dp[curr];
        }
    }

    return maxLen;
}