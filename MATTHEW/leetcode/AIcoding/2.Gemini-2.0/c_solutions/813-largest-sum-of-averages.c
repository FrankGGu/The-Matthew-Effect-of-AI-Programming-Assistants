#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double largestSumOfAverages(int* nums, int numsSize, int k) {
    double dp[numsSize + 1][k + 1];
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0.0;
        }
    }

    int sum[numsSize + 1];
    sum[0] = 0;
    for (int i = 1; i <= numsSize; i++) {
        sum[i] = sum[i - 1] + nums[i - 1];
    }

    for (int i = 1; i <= numsSize; i++) {
        dp[i][1] = (double)sum[i] / i;
    }

    for (int j = 2; j <= k; j++) {
        for (int i = j; i <= numsSize; i++) {
            for (int x = j - 1; x < i; x++) {
                double avg = (double)(sum[i] - sum[x]) / (i - x);
                dp[i][j] = fmax(dp[i][j], dp[x][j - 1] + avg);
            }
        }
    }

    return dp[numsSize][k];
}