#include <stdio.h>
#include <stdlib.h>

int minOperations(int* A, int ASize, int* B, int BSize) {
    int* dp = (int*)malloc((ASize + 1) * sizeof(int));
    for (int i = 0; i <= ASize; i++) {
        dp[i] = ASize + 1;
    }
    dp[0] = 0;

    for (int i = 0; i < ASize; i++) {
        for (int j = ASize; j > 0; j--) {
            if (A[i] > (j == 1 ? -1 : dp[j - 1])) {
                dp[j] = j;
            }
        }
        for (int k = 0; k < BSize; k++) {
            for (int j = ASize; j > 0; j--) {
                if (B[k] > (j == 1 ? -1 : dp[j - 1])) {
                    dp[j] = j;
                }
            }
        }
    }

    int res = ASize + 1;
    for (int i = 1; i <= ASize; i++) {
        res = res < dp[i] ? res : dp[i];
    }
    free(dp);
    return res == ASize + 1 ? -1 : res;
}