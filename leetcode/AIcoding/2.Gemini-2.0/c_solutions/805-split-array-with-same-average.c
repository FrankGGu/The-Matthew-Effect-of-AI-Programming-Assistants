#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canSplitArray(int* nums, int numsSize) {
    if (numsSize <= 1) return false;

    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    for (int len = 1; len < numsSize; len++) {
        if ((sum * len) % numsSize == 0) {
            int target = (sum * len) / numsSize;

            bool dp[len + 1][target + 1];
            for (int i = 0; i <= len; i++) {
                for (int j = 0; j <= target; j++) {
                    dp[i][j] = false;
                }
            }
            dp[0][0] = true;

            for (int numIndex = 0; numIndex < numsSize; numIndex++) {
                for (int i = len; i >= 1; i--) {
                    for (int j = target; j >= nums[numIndex]; j--) {
                        dp[i][j] = dp[i][j] || dp[i - 1][j - nums[numIndex]];
                    }
                }
            }

            if (dp[len][target]) return true;
        }
    }

    return false;
}