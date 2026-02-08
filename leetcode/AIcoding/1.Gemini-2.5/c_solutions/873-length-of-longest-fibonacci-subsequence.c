#include <stdlib.h>
#include <stdbool.h>

int lengthOfLongestFibonacciSubsequence(int* arr, int arrSize) {
    bool** dp = (bool**)malloc(arrSize * sizeof(bool*));
    for (int i = 0; i < arrSize; i++) {
        dp[i] = (bool*)malloc(arrSize * sizeof(bool));
        for (int j = 0; j < arrSize; j++) {
            dp[i][j] = false;
        }
    }

    int maxLen = 0;

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            dp[i][j] = true;
        }
    }

    for (int k = 2; k < arrSize; k++) {
        for (int j = 1; j < k; j++) {
            int target = arr[k] - arr[j];
            if (target >= arr[j]) {
                continue;
            }

            int i = 0;
            while (i < j && arr[i] < target) {
                i++;
            }

            if (i < j && arr[i] == target) {
                if (dp[i][j]) {
                    dp[j][k] = true;
                }
            }
        }
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            if (dp[i][j]) {
                int currentLen = 2;
                int prev = arr[i];
                int curr = arr[j];

                for (int k = j + 1; k < arrSize; k++) {
                    if (arr[k] == prev + curr) {
                        currentLen++;
                        prev = curr;
                        curr = arr[k];
                    }
                }
                if (currentLen > 2) { 
                    if (currentLen > maxLen) {
                        maxLen = currentLen;
                    }
                }
            }
        }
    }

    for (int i = 0; i < arrSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen;
}