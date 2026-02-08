#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxPoints(int** points, int pointsSize, int* pointsColSize){
    int m = pointsSize;
    int n = pointsColSize[0];

    long long dp[m][n];

    for (int j = 0; j < n; j++) {
        dp[0][j] = points[0][j];
    }

    for (int i = 1; i < m; i++) {
        long long left[n];
        long long right[n];

        left[0] = dp[i-1][0];
        for (int j = 1; j < n; j++) {
            left[j] = (dp[i-1][j] > (left[j-1] - 1) ? dp[i-1][j] : (left[j-1] - 1));
        }

        right[n-1] = dp[i-1][n-1];
        for (int j = n - 2; j >= 0; j--) {
            right[j] = (dp[i-1][j] > (right[j+1] - 1) ? dp[i-1][j] : (right[j+1] - 1));
        }

        for (int j = 0; j < n; j++) {
            dp[i][j] = points[i][j] + (left[j] > right[j] ? left[j] : right[j]) - 0;
        }
    }

    long long max = dp[m-1][0];
    for (int j = 1; j < n; j++) {
        if (dp[m-1][j] > max) {
            max = dp[m-1][j];
        }
    }

    return max;
}