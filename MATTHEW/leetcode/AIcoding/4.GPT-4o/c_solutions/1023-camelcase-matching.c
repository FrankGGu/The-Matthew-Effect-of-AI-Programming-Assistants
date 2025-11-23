bool isMatch(char *query, char *pattern) {
    int qLen = strlen(query), pLen = strlen(pattern);
    int dp[qLen + 1][pLen + 1];

    for (int i = 0; i <= qLen; i++) {
        for (int j = 0; j <= pLen; j++) {
            if (j == 0) {
                dp[i][j] = i == 0;
            } else {
                dp[i][j] = (i > 0 && dp[i - 1][j]) || (i > 0 && dp[i - 1][j - 1] && (query[i - 1] == pattern[j - 1] || pattern[j - 1] >= 'A' && pattern[j - 1] <= 'Z' && query[i - 1] == pattern[j - 1] + 32));
                if (j > 1 && pattern[j - 1] >= 'A' && pattern[j - 1] <= 'Z') {
                    dp[i][j] |= dp[i][j - 1];
                }
            }
        }
    }

    return dp[qLen][pLen];
}

bool* camelMatch(char **queries, int queriesSize, char *pattern, int* returnSize) {
    bool *result = (bool *)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        result[i] = isMatch(queries[i], pattern);
    }

    return result;
}