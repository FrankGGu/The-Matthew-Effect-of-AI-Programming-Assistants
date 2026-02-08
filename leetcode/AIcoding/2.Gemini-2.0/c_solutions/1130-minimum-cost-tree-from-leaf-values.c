#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mctFromLeafValues(int* arr, int arrSize) {
    int dp[arrSize][arrSize];
    int maxVal[arrSize][arrSize];

    for (int i = 0; i < arrSize; i++) {
        maxVal[i][i] = arr[i];
        dp[i][i] = 0;
    }

    for (int len = 2; len <= arrSize; len++) {
        for (int i = 0; i <= arrSize - len; i++) {
            int j = i + len - 1;
            dp[i][j] = INT_MAX;
            maxVal[i][j] = 0;
            for (int k = i; k < j; k++) {
                dp[i][j] = fmin(dp[i][j], dp[i][k] + dp[k + 1][j] + maxVal[i][k] * maxVal[k + 1][j]);
                maxVal[i][j] = fmax(maxVal[i][j], fmax(maxVal[i][k], maxVal[k + 1][j]));
            }
        }
    }

    return dp[0][arrSize - 1];
}