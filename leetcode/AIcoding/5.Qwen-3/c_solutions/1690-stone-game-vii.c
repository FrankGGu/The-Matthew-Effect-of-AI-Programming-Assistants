#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int stoneGameVII(int* stones, int stonesSize) {
    int* prefix = (int*)malloc(stonesSize * sizeof(int));
    prefix[0] = stones[0];
    for (int i = 1; i < stonesSize; i++) {
        prefix[i] = prefix[i - 1] + stones[i];
    }

    int** dp = (int**)malloc(stonesSize * sizeof(int*));
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = (int*)malloc(stonesSize * sizeof(int));
    }

    for (int i = 0; i < stonesSize; i++) {
        dp[i][i] = 0;
    }

    for (int length = 2; length <= stonesSize; length++) {
        for (int i = 0; i <= stonesSize - length; i++) {
            int j = i + length - 1;
            dp[i][j] = 0;
            if (i + 1 <= j) {
                dp[i][j] = dp[i + 1][j] + (prefix[j] - prefix[i + 1]);
            }
            if (j - 1 >= i) {
                dp[i][j] = fmax(dp[i][j], dp[i][j - 1] + (prefix[j - 1] - prefix[i]));
            }
        }
    }

    int result = dp[0][stonesSize - 1];

    for (int i = 0; i < stonesSize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefix);

    return result;
}