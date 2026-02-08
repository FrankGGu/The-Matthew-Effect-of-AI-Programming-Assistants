#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDistance(char * word1, char * word2){
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
                int insert = dp[i][j - 1];
                int delete = dp[i - 1][j];
                int replace = dp[i - 1][j - 1];
                int minVal = insert < delete ? insert : delete;
                minVal = minVal < replace ? minVal : replace;
                dp[i][j] = minVal + 1;
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