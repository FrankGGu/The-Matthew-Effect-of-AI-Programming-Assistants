#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthOfLongestSubsequence(int* nums, int numsSize, int target) {
    int dp[numsSize + 1][target + 1];

    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= target; j++) {
            if (j == 0) {
                dp[i][j] = 0;
            } else if (i == 0) {
                dp[i][j] = INT_MIN;
            } else {
                if (nums[i - 1] <= j) {
                    int include = dp[i - 1][j - nums[i - 1]];
                    if(include != INT_MIN)
                        include++;
                    dp[i][j] = (include > dp[i - 1][j]) ? include : dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }
    }

    return (dp[numsSize][target] <= 0 && target != 0) ? -1 : dp[numsSize][target];
}