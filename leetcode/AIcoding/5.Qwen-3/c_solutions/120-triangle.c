#include <stdio.h>
#include <stdlib.h>

int minimumTotal(int** triangle, int triangleSize, int* triangleColSize) {
    int* dp = (int*)malloc(triangleSize * sizeof(int));
    for (int i = 0; i < triangleSize; i++) {
        dp[i] = triangle[triangleSize - 1][i];
    }
    for (int i = triangleSize - 2; i >= 0; i--) {
        for (int j = 0; j <= i; j++) {
            dp[j] = triangle[i][j] + (dp[j] < dp[j + 1] ? dp[j] : dp[j + 1]);
        }
    }
    int result = dp[0];
    free(dp);
    return result;
}