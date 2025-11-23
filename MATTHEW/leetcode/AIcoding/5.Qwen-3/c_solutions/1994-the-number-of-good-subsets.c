#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int numberOfGoodSubsets(int* nums, int numsSize) {
    int mod = 1000000007;
    int count[31] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 1 && nums[i] <= 30) {
            count[nums[i]]++;
        }
    }

    long long dp[31] = {0};
    dp[0] = 1;

    for (int i = 2; i <= 30; i++) {
        if (count[i] == 0) continue;
        if ((i & (i - 1)) != 0) continue;
        for (int j = 30; j >= i; j--) {
            if ((j & i) == 0) {
                dp[j] = (dp[j] + dp[j ^ i] * count[i]) % mod;
            }
        }
    }

    long long result = 0;
    for (int i = 1; i <= 30; i++) {
        if ((i & (i - 1)) == 0) {
            result = (result + dp[i]) % mod;
        }
    }

    return result;
}