#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int min3(int a, int b, int c) {
    return min(a, min(b, c));
}

int minDistance(char *word1, char *word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);

    int **dp = (int **)malloc((len1 + 1) * sizeof(int *));
    for (int i = 0; i <= len1; i++) {
        dp[i] = (int *)malloc((len2 + 1) * sizeof(int));
    }

    for (int i = 0; i <= len1; i++) {
        dp[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
        dp[0][j] = j;
    }

    for (int i = 1; i <= len1; i++) {
        for (int j = 1; j <= len2; j++) {
            if (word1[i - 1] == word2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            } else {
                dp[i][j] = 1 + min3(dp[i - 1][j - 1], // replace
                                    dp[i - 1][j],     // delete
                                    dp[i][j - 1]);    // insert
            }
        }
    }

    int result = dp[len1][len2];

    for (int i = 0; i <= len1; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}