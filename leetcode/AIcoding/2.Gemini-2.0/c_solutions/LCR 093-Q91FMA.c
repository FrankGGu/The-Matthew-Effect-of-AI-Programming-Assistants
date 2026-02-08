#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lenLongestFibSubseq(int* arr, int arrSize) {
    if (arrSize < 3) {
        return 0;
    }

    int maxLen = 0;
    int dp[arrSize][arrSize];
    int index[1001] = {0};

    for (int i = 0; i < arrSize; i++) {
        index[arr[i]] = i + 1;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            dp[i][j] = 2;
            int target = arr[i] + arr[j];
            if (target <= 1000 && index[target] > 0) {
                int k = index[target] - 1;
                if (k > j) {
                    dp[j][k] = dp[i][j] + 1;
                    if (dp[j][k] > maxLen) {
                        maxLen = dp[j][k];
                    }
                }
            }
        }
    }

    return maxLen > 2 ? maxLen : 0;
}