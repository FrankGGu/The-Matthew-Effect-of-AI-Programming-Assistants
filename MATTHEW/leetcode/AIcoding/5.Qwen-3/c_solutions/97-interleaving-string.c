#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** create2DArray(int rows, int cols) {
    int** arr = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        arr[i] = (int*)malloc(cols * sizeof(int));
    }
    return arr;
}

void free2DArray(int** arr, int rows) {
    for (int i = 0; i < rows; i++) {
        free(arr[i]);
    }
    free(arr);
}

int isInterleave(char* s1, char* s2, char* s3) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int len3 = strlen(s3);

    if (len1 + len2 != len3) {
        return 0;
    }

    int** dp = create2DArray(len1 + 1, len2 + 1);

    dp[0][0] = 1;

    for (int i = 1; i <= len1; i++) {
        dp[i][0] = (dp[i - 1][0] && s1[i - 1] == s3[i - 1]);
    }

    for (int j = 1; j <= len2; j++) {
        dp[0][j] = (dp[0][j - 1] && s2[j - 1] == s3[j - 1]);
    }

    for (int i = 1; i <= len1; i++) {
        for (int j = 1; j <= len2; j++) {
            dp[i][j] = (dp[i - 1][j] && s1[i - 1] == s3[i + j - 1]) || 
                       (dp[i][j - 1] && s2[j - 1] == s3[i + j - 1]);
        }
    }

    int result = dp[len1][len2];
    free2DArray(dp, len1 + 1);
    return result;
}