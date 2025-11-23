#include <string.h>
#include <stdlib.h>
#include <limits.h>

int minimumCost(char *s, char **words, int wordsSize, int *costs) {
    int n = strlen(s);

    int *dp = (int *)malloc(sizeof(int) * (n + 1));

    dp[0] = 0;
    for (int i = 1; i <= n; i++) {
        dp[i] = -1; 
    }

    for (int i = 0; i < n; i++) {
        if (dp[i] == -1) {
            continue;
        }

        for (int k = 0; k < wordsSize; k++) {
            char *word = words[k];
            int cost = costs[k];
            int wordLen = strlen(word);

            if (i + wordLen <= n) {
                int match = 1;
                for (int l = 0; l < wordLen; l++) {
                    if (s[i + l] != word[l]) {
                        match = 0;
                        break;
                    }
                }

                if (match) {
                    if (dp[i + wordLen] == -1 || dp[i] + cost < dp[i + wordLen]) {
                        dp[i + wordLen] = dp[i] + cost;
                    }
                }
            }
        }
    }

    int result = dp[n];
    free(dp);

    return result;
}