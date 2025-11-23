#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int dp[1 << 14][14];

int specialPerm(int* nums, int numsSize) {
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < numsSize; i++) {
        dp[1 << i][i] = 1;
    }

    for (int mask = 1; mask < (1 << numsSize); mask++) {
        for (int i = 0; i < numsSize; i++) {
            if ((mask & (1 << i)) && dp[mask][i] > 0) {
                for (int j = 0; j < numsSize; j++) {
                    if (!(mask & (1 << j))) {
                        if (nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0) {
                            dp[mask | (1 << j)][j] = (dp[mask | (1 << j)][j] + dp[mask][i]) % MOD;
                        }
                    }
                }
            }
        }
    }

    int totalSpecialPermutations = 0;
    int fullMask = (1 << numsSize) - 1;
    for (int i = 0; i < numsSize; i++) {
        totalSpecialPermutations = (totalSpecialPermutations + dp[fullMask][i]) % MOD;
    }

    return totalSpecialPermutations;
}