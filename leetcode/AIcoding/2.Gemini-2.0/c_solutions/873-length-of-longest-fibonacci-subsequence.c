#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lenLongestFibSubseq(int* arr, int arrSize) {
    int maxLen = 0;
    int** dp = (int**)malloc(arrSize * sizeof(int*));
    for (int i = 0; i < arrSize; i++) {
        dp[i] = (int*)malloc(arrSize * sizeof(int));
        for (int j = 0; j < arrSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int k = 2; k < arrSize; k++) {
        int i = 0, j = k - 1;
        while (i < j) {
            int sum = arr[i] + arr[j];
            if (sum == arr[k]) {
                dp[j][k] = dp[i][j] > 0 ? dp[i][j] + 1 : 2;
                maxLen = (maxLen > dp[j][k]) ? maxLen : dp[j][k];
                i++;
                j--;
            } else if (sum < arr[k]) {
                i++;
            } else {
                j--;
            }
        }
    }

    for (int i = 0; i < arrSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen > 0 ? maxLen + 1 : 0;
}