#include <stdlib.h>
#include <string.h>

static void reverseString(char* str) {
    int length = strlen(str);
    int i, j;
    char temp;
    for (i = 0, j = length - 1; i < j; i++, j--) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
    }
}

char* shortestCommonSupersequence(char* str1, char* str2) {
    int m = strlen(str1);
    int n = strlen(str2);

    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            if (i == 0 || j == 0) {
                dp[i][j] = 0;
            } else if (str1[i - 1] == str2[j - 1]) {
                dp[i][j] = 1 + dp[i - 1][j - 1];
            } else {
                dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
            }
        }
    }

    char* result = (char*)malloc((m + n + 1) * sizeof(char));
    int k = 0; 

    int i = m;
    int j = n;

    while (i > 0 || j > 0) {
        if (i == 0) {
            result[k++] = str2[j - 1];
            j--;
        } else if (j == 0) {
            result[k++] = str1[i - 1];
            i--;
        } else if (str1[i - 1] == str2[j - 1]) {
            result[k++] = str1[i - 1];
            i--;
            j--;
        } else {
            if (dp[i - 1][j] > dp[i][j - 1]) {
                result[k++] = str1[i - 1];
                i--;
            } else {
                result[k++] = str2[j - 1];
                j--;
            }
        }
    }
    result[k] = '\0';

    reverseString(result);

    for (int x = 0; x <= m; x++) {
        free(dp[x]);
    }
    free(dp);

    return result;
}