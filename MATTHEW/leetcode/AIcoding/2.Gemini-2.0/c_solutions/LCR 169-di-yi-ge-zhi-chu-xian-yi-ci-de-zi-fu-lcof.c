#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int split(char *s, char **wordDict, int wordDictSize) {
    int n = strlen(s);
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    memset(dp, 0, (n + 1) * sizeof(int));
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < wordDictSize; j++) {
            int len = strlen(wordDict[j]);
            if (i >= len && strncmp(s + i - len, wordDict[j], len) == 0) {
                dp[i] = dp[i] || dp[i - len];
            }
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}