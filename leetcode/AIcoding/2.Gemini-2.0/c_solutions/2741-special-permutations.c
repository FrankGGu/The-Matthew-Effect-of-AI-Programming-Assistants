#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int specialPerm(int* nums, int numsSize){
    int mod = 1000000007;
    long long dp[1 << numsSize][numsSize];
    for (int i = 0; i < (1 << numsSize); i++) {
        for (int j = 0; j < numsSize; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        dp[1 << i][i] = 1;
    }

    for (int mask = 0; mask < (1 << numsSize); mask++) {
        for (int i = 0; i < numsSize; i++) {
            if (dp[mask][i] > 0) {
                for (int j = 0; j < numsSize; j++) {
                    if (!(mask & (1 << j))) {
                        if (nums[j] % nums[i] == 0 || nums[i] % nums[j] == 0) {
                            dp[mask | (1 << j)][j] = (dp[mask | (1 << j)][j] + dp[mask][i]) % mod;
                        }
                    }
                }
            }
        }
    }

    long long ans = 0;
    for (int i = 0; i < numsSize; i++) {
        ans = (ans + dp[(1 << numsSize) - 1][i]) % mod;
    }

    return (int)ans;
}