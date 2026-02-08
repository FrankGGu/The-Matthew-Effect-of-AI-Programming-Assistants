#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int burstBalloons(int* nums, int numsSize) {
    int** dp = (int**)malloc((numsSize + 2) * sizeof(int*));
    for (int i = 0; i <= numsSize + 1; i++) {
        dp[i] = (int*)malloc((numsSize + 2) * sizeof(int));
    }

    for (int i = 1; i <= numsSize; i++) {
        dp[i][i] = nums[i - 1];
    }

    for (int length = 2; length <= numsSize; length++) {
        for (int i = 1; i <= numsSize - length + 1; i++) {
            int j = i + length - 1;
            dp[i][j] = 0;
            for (int k = i; k <= j; k++) {
                int left = (i == 1) ? 0 : dp[i][k - 1];
                int right = (j == numsSize) ? 0 : dp[k + 1][j];
                int val = nums[k - 1];
                if (i > 1) val *= nums[i - 2];
                if (j < numsSize) val *= nums[j];
                dp[i][j] = max(dp[i][j], left + right + val);
            }
        }
    }

    int result = dp[1][numsSize];
    for (int i = 0; i <= numsSize + 1; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}