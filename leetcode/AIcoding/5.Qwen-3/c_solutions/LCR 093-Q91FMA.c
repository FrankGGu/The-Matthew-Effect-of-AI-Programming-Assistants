#include <stdio.h>
#include <stdlib.h>

int lenLongestFibSubseq(int* arr, int arrSize) {
    int n = arrSize;
    int maxLen = 0;
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = 2;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int prev = arr[j] - arr[i];
            for (int k = 0; k < i; k++) {
                if (arr[k] == prev) {
                    dp[i][j] = dp[k][i] + 1;
                    break;
                }
            }
            if (dp[i][j] > maxLen) {
                maxLen = dp[i][j];
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    return maxLen;
}