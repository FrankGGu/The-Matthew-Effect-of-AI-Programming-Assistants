#include <limits.h>
#include <stdlib.h>
#include <stdio.h>

int minimumTotal(int** triangle, int triangleSize) {
    if (triangleSize == 0) {
        return 0;
    }

    if (triangleSize == 1) {
        return triangle[0][0];
    }

    int* dp = (int*)malloc(sizeof(int) * triangleSize);
    if (dp == NULL) {
        return -1; // Handle memory allocation failure
    }

    // Initialize dp with the last row of the triangle
    for (int i = 0; i < triangleSize; i++) {
        dp[i] = triangle[triangleSize - 1][i];
    }

    // Iterate from the second to last row up to the first row
    for (int i = triangleSize - 2; i >= 0; i--) {
        for (int j = 0; j <= i; j++) {
            dp[j] = triangle[i][j] + (dp[j] < dp[j+1] ? dp[j] : dp[j+1]);
        }
    }

    int result = dp[0];
    free(dp);
    return result;
}