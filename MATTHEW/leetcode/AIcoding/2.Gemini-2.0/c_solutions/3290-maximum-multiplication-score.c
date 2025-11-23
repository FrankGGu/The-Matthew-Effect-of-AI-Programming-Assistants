#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int dp[multipliersSize + 1];
    for (int i = 0; i <= multipliersSize; i++) {
        dp[i] = 0;
    }

    for (int i = multipliersSize - 1; i >= 0; i--) {
        int new_dp[multipliersSize + 1];
        for (int x = 0; x <= i; x++) {
            new_dp[x] = multipliers[i] * nums[x] + dp[x + 1];
            int right = numsSize - 1 - (i - x);
            int temp = multipliers[i] * nums[right] + dp[x];
            if (temp > new_dp[x]) {
                new_dp[x] = temp;
            }
        }
        for (int j = 0; j <= i; j++) {
            dp[j] = new_dp[j];
        }
    }

    return dp[0];
}