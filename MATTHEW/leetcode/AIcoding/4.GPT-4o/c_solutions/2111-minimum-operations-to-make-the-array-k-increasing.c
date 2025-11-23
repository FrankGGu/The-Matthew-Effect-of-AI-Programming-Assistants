#include <stdlib.h>

int minOperations(int* arr, int arrSize, int k) {
    if (k == 0) return 0;

    int totalOps = 0;
    for (int start = 0; start < k; start++) {
        int* subsequence = (int*)malloc(sizeof(int) * ((arrSize + k - 1) / k));
        int len = 0;

        for (int i = start; i < arrSize; i += k) {
            subsequence[len++] = arr[i];
        }

        int* dp = (int*)malloc(sizeof(int) * len);
        for (int i = 0; i < len; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                if (subsequence[j] <= subsequence[i]) {
                    dp[i] = dp[i] > dp[j] + 1 ? dp[i] : dp[j] + 1;
                }
            }
        }

        int lisLength = 0;
        for (int i = 0; i < len; i++) {
            if (dp[i] > lisLength) {
                lisLength = dp[i];
            }
        }

        totalOps += len - lisLength;
        free(subsequence);
        free(dp);
    }

    return totalOps;
}