int longestPalindrome(char * word1, char * word2){
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    int total_len = len1 + len2;
    char *s = malloc(total_len + 1);
    strcpy(s, word1);
    strcat(s, word2);

    int **dp = malloc(total_len * sizeof(int *));
    for (int i = 0; i < total_len; i++) {
        dp[i] = malloc(total_len * sizeof(int));
        for (int j = 0; j < total_len; j++) {
            dp[i][j] = 0;
        }
        dp[i][i] = 1;
    }

    for (int i = total_len - 1; i >= 0; i--) {
        for (int j = i + 1; j < total_len; j++) {
            if (s[i] == s[j]) {
                dp[i][j] = dp[i + 1][j - 1] + 2;
            } else {
                dp[i][j] = dp[i + 1][j] > dp[i][j - 1] ? dp[i + 1][j] : dp[i][j - 1];
            }
        }
    }

    int res = 0;
    for (int i = 0; i < len1; i++) {
        for (int j = 0; j < len2; j++) {
            if (word1[i] == word2[j]) {
                int len = dp[i][len1 + j];
                if (len > res) {
                    res = len;
                }
            }
        }
    }

    for (int i = 0; i < total_len; i++) {
        free(dp[i]);
    }
    free(dp);
    free(s);

    return res;
}