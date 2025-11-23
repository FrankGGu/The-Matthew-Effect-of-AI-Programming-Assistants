int longestPalindrome(char* s, int k) {
    int n = strlen(s);
    int dp[26][26];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        for (int j = 0; j < 26; j++) {
            dp[c][j] = dp[j][c] + 1;
        }
    }

    int maxLen = 1;
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            int len = dp[i][j];
            int diff = (i == j) ? 0 : 1;
            if (diff <= k) {
                maxLen = (len > maxLen) ? len : maxLen;
            }
        }
    }

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i == j) continue;
            for (int x = 0; x < 26; x++) {
                for (int y = 0; y < 26; y++) {
                    if (x == y) continue;
                    int len = dp[i][j] + dp[x][y];
                    int op1 = (i == j) ? 0 : 1;
                    int op2 = (x == y) ? 0 : 1;
                    int totalOps = op1 + op2;
                    if (totalOps <= k && len > maxLen) {
                        maxLen = len;
                    }
                }
            }
        }
    }

    return maxLen;
}