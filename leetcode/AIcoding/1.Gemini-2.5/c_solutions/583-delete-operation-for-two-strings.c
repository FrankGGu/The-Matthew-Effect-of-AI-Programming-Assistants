#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int minDistance(char * word1, char * word2){
    int m = strlen(word1);
    int n = strlen(word2);

    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)calloc((n + 1), sizeof(int));
    }

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (word1[i-1] == word2[j-1]) {
                dp[i][j] = 1 + dp[i-1][j-1];
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
            }
        }
    }

    int lcs_len = dp[m][n];

    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return (m - lcs_len) + (n - lcs_len);
}