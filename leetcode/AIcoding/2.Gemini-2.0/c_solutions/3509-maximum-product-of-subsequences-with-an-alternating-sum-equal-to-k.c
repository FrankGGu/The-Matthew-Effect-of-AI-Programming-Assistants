#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int solve(int* nums, int numsSize, int k, int index, int sum, int sign, long long product, long long*** dp) {
    if (index == numsSize) {
        if (sum == k) {
            return (int)product;
        } else {
            return 0;
        }
    }

    if (dp[index][sum + 5000][sign + 1] != -1) {
        return (int)dp[index][sum + 5000][sign + 1];
    }

    long long result = 0;

    // Option 1: Exclude the current number
    result = (result + solve(nums, numsSize, k, index + 1, sum, sign, product, dp)) % MOD;

    // Option 2: Include the current number
    result = (result + solve(nums, numsSize, k, index + 1, sum + sign * nums[index], sign * -1, (product * nums[index]) % MOD, dp)) % MOD;

    dp[index][sum + 5000][sign + 1] = result;
    return (int)result;
}

int maxProductSubsequences(int* nums, int numsSize, int k) {
    long long*** dp = (long long***)malloc(numsSize * sizeof(long long**));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = (long long**)malloc(10001 * sizeof(long long*));
        for (int j = 0; j < 10001; j++) {
            dp[i][j] = (long long*)malloc(3 * sizeof(long long));
            for (int l = 0; l < 3; l++) {
                dp[i][j][l] = -1;
            }
        }
    }

    int result = solve(nums, numsSize, k, 0, 0, 1, 1, dp);

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < 10001; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}