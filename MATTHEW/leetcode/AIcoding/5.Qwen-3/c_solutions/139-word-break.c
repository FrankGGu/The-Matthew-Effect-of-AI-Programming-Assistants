#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool wordBreak(char *s, char **wordDict, int wordDictSize) {
    int n = strlen(s);
    bool *dp = (bool *)malloc((n + 1) * sizeof(bool));
    memset(dp, false, (n + 1) * sizeof(bool));
    dp[0] = true;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < wordDictSize; j++) {
            int len = strlen(wordDict[j]);
            if (i >= len && dp[i - len] && strncmp(s + i - len, wordDict[j], len) == 0) {
                dp[i] = true;
                break;
            }
        }
    }

    bool result = dp[n];
    free(dp);
    return result;
}