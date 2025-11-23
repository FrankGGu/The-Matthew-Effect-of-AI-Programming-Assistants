#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return strlen(*(const char **)a) - strlen(*(const char **)b);
}

int longestStrChain(char **words, int wordsSize) {
    qsort(words, wordsSize, sizeof(char *), cmp);

    int *dp = (int *)calloc(wordsSize, sizeof(int));
    int maxLength = 1;

    for (int i = 0; i < wordsSize; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (strlen(words[i]) == strlen(words[j]) + 1) {
                int k = 0, l = 0, count = 0;
                while (k < strlen(words[i]) && l < strlen(words[j])) {
                    if (words[i][k] == words[j][l]) {
                        k++;
                        l++;
                    } else {
                        k++;
                        count++;
                    }
                    if (count > 1) break;
                }
                if (count <= 1 && (l == strlen(words[j]))) {
                    dp[i] = dp[i] > dp[j] + 1 ? dp[i] : dp[j] + 1;
                }
            }
        }
        maxLength = maxLength > dp[i] ? maxLength : dp[i];
    }

    free(dp);
    return maxLength;
}