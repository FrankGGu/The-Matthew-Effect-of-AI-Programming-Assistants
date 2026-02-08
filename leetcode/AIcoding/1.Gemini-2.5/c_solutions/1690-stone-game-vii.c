#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int stoneGameVII(int* stones, int stonesSize) {
    int n = stonesSize;

    int* prefixSum = (int*)malloc((n + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < n; ++i) {
        prefixSum[i+1] = prefixSum[i] + stones[i];
    }

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; ++i) {
        dp[i] = (int*)malloc(n * sizeof(int));
        dp[i][i] = 0; 
    }

    for (int len = 2; len <= n; ++len) {
        for (int i = 0; i <= n - len; ++i) {
            int j = i + len - 1;

            int currentSum = prefixSum[j+1] - prefixSum[i];

            int choice1 = (currentSum - stones[i]) - dp[i+1][j];
            int choice2 = (currentSum - stones[j]) - dp[i][j-1];

            dp[i][j] = max(choice1, choice2);
        }
    }

    int result = dp[0][n-1];

    for (int i = 0; i < n; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(prefixSum);

    return result;
}