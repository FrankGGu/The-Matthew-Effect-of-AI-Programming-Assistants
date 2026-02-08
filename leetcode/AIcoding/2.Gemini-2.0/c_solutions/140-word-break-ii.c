#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **wordBreak(char *s, char **wordDict, int wordDictSize, int *returnSize) {
    int n = strlen(s);
    int *dp = (int *)malloc((n + 1) * sizeof(int));
    memset(dp, 0, (n + 1) * sizeof(int));
    dp[0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            if (dp[j]) {
                char sub[i - j + 1];
                strncpy(sub, s + j, i - j);
                sub[i - j] = '\0';

                for (int k = 0; k < wordDictSize; k++) {
                    if (strcmp(sub, wordDict[k]) == 0) {
                        dp[i] = 1;
                        break;
                    }
                }
            }
            if (dp[i]) break;
        }
    }

    if (!dp[n]) {
        *returnSize = 0;
        free(dp);
        return NULL;
    }

    char **result = (char **)malloc(1000 * sizeof(char *));
    int resultIndex = 0;
    char path[n * 2 + 1];
    path[0] = '\0';

    void backtrack(int index, char *currentPath) {
        if (index == n) {
            result[resultIndex] = (char *)malloc((strlen(currentPath) + 1) * sizeof(char));
            strcpy(result[resultIndex], currentPath);
            resultIndex++;
            return;
        }

        for (int i = index + 1; i <= n; i++) {
            char sub[i - index + 1];
            strncpy(sub, s + index, i - index);
            sub[i - index] = '\0';

            for (int k = 0; k < wordDictSize; k++) {
                if (strcmp(sub, wordDict[k]) == 0) {
                    char tempPath[n * 2 + 1];
                    strcpy(tempPath, currentPath);
                    if (strlen(tempPath) > 0) {
                        strcat(tempPath, " ");
                    }
                    strcat(tempPath, sub);

                    backtrack(i, tempPath);
                }
            }
        }
    }

    backtrack(0, path);

    *returnSize = resultIndex;
    free(dp);
    return result;
}