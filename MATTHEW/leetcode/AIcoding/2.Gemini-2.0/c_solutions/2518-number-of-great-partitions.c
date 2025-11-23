#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countPartitions(int* nums, int numsSize, int k) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    if (sum < 2 * k) {
        return 0;
    }

    long long dp[k];
    for (int i = 0; i < k; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = k - 1; j >= nums[i]; j--) {
            dp[j] = (dp[j] + dp[j - nums[i]]) % MOD;
        }
    }

    long long lessThanK = 0;
    for (int i = 0; i < k; i++) {
        lessThanK = (lessThanK + dp[i]) % MOD;
    }

    long long totalSubsets = 1;
    for (int i = 0; i < numsSize; i++) {
        totalSubsets = (totalSubsets * 2) % MOD;
    }

    long long result = (totalSubsets - 2 * lessThanK) % MOD;
    if (result < 0) {
        result += MOD;
    }

    return (int)result;
}