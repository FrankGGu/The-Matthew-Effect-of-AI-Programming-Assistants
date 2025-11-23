#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve(int* slices, int start, int end, int n) {
    int dp[n + 1][end - start + 1];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= end - start; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= end - start; j++) {
            dp[i][j] = max(dp[i][j - 1], (slices[start + j - 1] + (j >= 2 ? dp[i - 1][j - 2] : 0)));
        }
    }

    return dp[n][end - start];
}

int maxSizeSlices(int* slices, int slicesSize) {
    int n = slicesSize / 3;
    return max(solve(slices, 0, slicesSize - 1, n), solve(slices, 1, slicesSize, n));
}