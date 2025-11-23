#include <string.h>
#include <stdlib.h>

int minValidStrings(char** words, int wordsSize, char* target) {
    int n = strlen(target);
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = n + 1;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == n + 1) continue;

        for (int j = 0; j < wordsSize; j++) {
            char* word = words[j];
            int len = strlen(word);
            if (i + len <= n && strncmp(target + i, word, len) == 0) {
                if (dp[i] + 1 < dp[i + len]) {
                    dp[i + len] = dp[i] + 1;
                }
            }
        }
    }

    int result = dp[n] == n + 1 ? -1 : dp[n];
    free(dp);
    return result;
}