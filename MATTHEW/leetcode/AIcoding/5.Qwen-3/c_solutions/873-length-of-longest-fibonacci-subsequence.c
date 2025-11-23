#include <stdio.h>
#include <stdlib.h>

int longestLongestFibonacciSubsequence(int* arr, int arrSize) {
    int n = arrSize;
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)calloc(n, sizeof(int));
    }

    int maxLen = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < i; j++) {
            int prev = arr[i] - arr[j];
            int k = -1;
            for (int m = 0; m < j; m++) {
                if (arr[m] == prev) {
                    k = m;
                    break;
                }
            }
            if (k != -1) {
                dp[j][i] = dp[k][j] + 1;
                maxLen = (dp[j][i] > maxLen) ? dp[j][i] : maxLen;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen;
}