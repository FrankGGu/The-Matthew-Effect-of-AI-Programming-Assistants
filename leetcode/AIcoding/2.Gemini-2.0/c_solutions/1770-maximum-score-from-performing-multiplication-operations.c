#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int dp[multipliersSize + 1][multipliersSize + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = multipliersSize - 1; i >= 0; i--) {
        for (int left = 0; left <= i; left++) {
            int right = numsSize - 1 - (i - left);

            int option1 = nums[left] * multipliers[i] + dp[i + 1][left + 1];
            int option2 = nums[right] * multipliers[i] + dp[i + 1][left];

            dp[i][left] = (option1 > option2) ? option1 : option2;
        }
    }

    return dp[0][0];
}