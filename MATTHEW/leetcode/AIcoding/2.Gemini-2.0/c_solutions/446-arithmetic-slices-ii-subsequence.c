#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfArithmeticSlices(int* nums, int numsSize) {
    int ans = 0;
    long long dp[numsSize][numsSize];
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            long long diff = (long long)nums[i] - (long long)nums[j];
            if (diff > INT_MAX || diff < INT_MIN) continue;

            for (int k = 0; k < j; k++) {
                if ((long long)nums[j] - (long long)nums[k] == diff) {
                    dp[i][j] += 1 + dp[j][k];
                }
            }
            ans += dp[i][j];
        }
    }

    return ans;
}