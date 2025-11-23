#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shortestCommonSupersequence(char* s1, char* s2) {
    int m = strlen(s1), n = strlen(s2);
    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            if (i == 0) dp[i][j] = j;
            else if (j == 0) dp[i][j] = i;
            else {
                dp[i][j] = (s1[i - 1] == s2[j - 1]) ? dp[i - 1][j - 1] + 1 : (dp[i - 1][j] < dp[i][j - 1] ? dp[i - 1][j] + 1 : dp[i][j - 1] + 1);
            }
        }
    }

    int len = dp[m][n];
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int i = m, j = n, k = 0;

    while (i > 0 && j > 0) {
        if (s1[i - 1] == s2[j - 1]) {
            result[k++] = s1[i - 1];
            i--;
            j--;
        } else if (dp[i - 1][j] < dp[i][j - 1]) {
            result[k++] = s1[i - 1];
            i--;
        } else {
            result[k++] = s2[j - 1];
            j--;
        }
    }

    while (i > 0) {
        result[k++] = s1[i - 1];
        i--;
    }

    while (j > 0) {
        result[k++] = s2[j - 1];
        j--;
    }

    result[k] = '\0';
    for (int l = 0; l < len / 2; l++) {
        char temp = result[l];
        result[l] = result[len - 1 - l];
        result[len - 1 - l] = temp;
    }

    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}