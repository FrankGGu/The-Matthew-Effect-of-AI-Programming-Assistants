#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *shortestCommonSupersequence(char *str1, char *str2) {
    int m = strlen(str1);
    int n = strlen(str2);

    int dp[m + 1][n + 1];

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            if (i == 0 || j == 0) {
                dp[i][j] = 0;
            } else if (str1[i - 1] == str2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
            }
        }
    }

    int len = m + n - dp[m][n];
    char *result = (char *)malloc((len + 1) * sizeof(char));
    result[len] = '\0';

    int i = m, j = n, k = len - 1;
    while (i > 0 && j > 0) {
        if (str1[i - 1] == str2[j - 1]) {
            result[k--] = str1[i - 1];
            i--;
            j--;
        } else if (dp[i - 1][j] > dp[i][j - 1]) {
            result[k--] = str1[i - 1];
            i--;
        } else {
            result[k--] = str2[j - 1];
            j--;
        }
    }

    while (i > 0) {
        result[k--] = str1[i - 1];
        i--;
    }

    while (j > 0) {
        result[k--] = str2[j - 1];
        j--;
    }

    return result;
}