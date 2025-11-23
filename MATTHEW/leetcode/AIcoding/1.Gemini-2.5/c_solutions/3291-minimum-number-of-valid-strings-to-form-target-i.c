#include <string.h>
#include <stdlib.h>
#include <limits.h>

int minimumStrings(char *target, char **words, int wordsSize) {
    int targetLen = strlen(target);
    int *dp = (int *)malloc((targetLen + 1) * sizeof(int));

    for (int i = 0; i <= targetLen; ++i) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < targetLen; ++i) {
        if (dp[i] == INT_MAX) {
            continue;
        }

        for (int j = 0; j < wordsSize; ++j) {
            char *word = words[j];
            int wordLen = strlen(word);

            if (i + wordLen <= targetLen) {
                if (strncmp(target + i, word, wordLen) == 0) {
                    if (dp[i] != INT_MAX && dp[i] + 1 < dp[i + wordLen]) {
                        dp[i + wordLen] = dp[i] + 1;
                    }
                }
            }
        }
    }

    int result = dp[targetLen];
    free(dp);

    return (result == INT_MAX) ? -1 : result;
}