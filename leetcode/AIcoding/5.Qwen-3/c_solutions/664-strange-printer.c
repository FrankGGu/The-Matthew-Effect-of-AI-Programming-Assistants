#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int strangePrinter(char* s, int sSize) {
    if (sSize == 0) return 0;

    int** dp = (int**)malloc(sSize * sizeof(int*));
    for (int i = 0; i < sSize; i++) {
        dp[i] = (int*)malloc(sSize * sizeof(int));
    }

    for (int i = 0; i < sSize; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= sSize; length++) {
        for (int i = 0; i <= sSize - length; i++) {
            int j = i + length - 1;
            dp[i][j] = dp[i][j-1] + 1;
            for (int k = i; k < j; k++) {
                if (s[k] == s[j]) {
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k+1][j-1]);
                }
            }
        }
    }

    int result = dp[0][sSize-1];

    for (int i = 0; i < sSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}