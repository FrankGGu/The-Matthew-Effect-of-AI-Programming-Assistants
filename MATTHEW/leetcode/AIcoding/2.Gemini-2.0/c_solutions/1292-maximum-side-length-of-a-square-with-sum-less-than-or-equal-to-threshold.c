#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSideLength(int** mat, int matSize, int* matColSize, int threshold) {
    int n = matSize;
    int m = matColSize[0];
    int prefixSum[n + 1][m + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            prefixSum[i][j] = 0;
        }
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + mat[i - 1][j - 1];
        }
    }
    int ans = 0;
    for (int k = 1; k <= fmin(n, m); k++) {
        for (int i = k; i <= n; i++) {
            for (int j = k; j <= m; j++) {
                int sum = prefixSum[i][j] - prefixSum[i - k][j] - prefixSum[i][j - k] + prefixSum[i - k][j - k];
                if (sum <= threshold) {
                    ans = k;
                }
            }
        }
    }
    return ans;
}