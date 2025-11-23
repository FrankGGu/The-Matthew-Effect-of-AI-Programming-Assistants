#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int beautifulPartitions(int* nums, int numsSize, int k, int minLength) {
    if (nums[0] % k != 0) {
        return 0;
    }
    if (nums[numsSize - 1] % k == 0) {
        return 0;
    }

    int dp[numsSize + 1];
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 1; i <= numsSize; i++) {
        for (int j = 1; j <= k; j++) {
            int currentSum = 0;
            for (int l = i - 1; l >= 0; l--) {
                currentSum += nums[l];
                if (i - l >= minLength && currentSum % k == 0) {
                    dp[i] = (dp[i] + dp[l]) % MOD;
                }
            }
        }
    }

    return dp[numsSize];
}