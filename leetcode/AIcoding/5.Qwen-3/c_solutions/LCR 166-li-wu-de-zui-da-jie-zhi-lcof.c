#include <stdio.h>
#include <stdlib.h>

int jewelleryValue(int** frame, int frameSize, int* frameColSize) {
    int m = frameSize;
    int n = frameColSize[0];
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }
    dp[0][0] = frame[0][0];
    for (int j = 1; j < n; j++) {
        dp[0][j] = dp[0][j - 1] + frame[0][j];
    }
    for (int i = 1; i < m; i++) {
        dp[i][0] = dp[i - 1][0] + frame[i][0];
    }
    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            dp[i][j] = fmax(dp[i - 1][j], dp[i][j - 1]) + frame[i][j];
        }
    }
    int result = dp[m - 1][n - 1];
    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}