#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int getMaximumScore(int* houseRobber1, int houseRobber1Size, int* houseRobber2, int houseRobber2Size) {
    int i, j;
    int** dp = (int**)malloc(houseRobber1Size * sizeof(int*));
    for (i = 0; i < houseRobber1Size; i++) {
        dp[i] = (int*)malloc(houseRobber2Size * sizeof(int));
    }

    dp[0][0] = houseRobber1[0] + houseRobber2[0];

    for (i = 1; i < houseRobber1Size; i++) {
        dp[i][0] = dp[i - 1][0] + houseRobber1[i];
    }

    for (j = 1; j < houseRobber2Size; j++) {
        dp[0][j] = dp[0][j - 1] + houseRobber2[j];
    }

    for (i = 1; i < houseRobber1Size; i++) {
        for (j = 1; j < houseRobber2Size; j++) {
            dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]) + houseRobber1[i] + houseRobber2[j];
        }
    }

    int result = dp[houseRobber1Size - 1][houseRobber2Size - 1];

    for (i = 0; i < houseRobber1Size; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}