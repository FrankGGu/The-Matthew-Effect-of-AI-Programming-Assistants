#include <stdlib.h>
#include <string.h>

int combinationSum4(int* nums, int numsSize, int target) {
    unsigned int* dp = (unsigned int*)malloc(sizeof(unsigned int) * (target + 1));
    if (dp == NULL) {
        return 0; 
    }

    memset(dp, 0, sizeof(unsigned int) * (target + 1));
    dp[0] = 1;

    for (int i = 1; i <= target; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i >= nums[j]) {
                dp[i] += dp[i - nums[j]];
            }
        }
    }

    unsigned int result = dp[target];

    free(dp);

    return (int)result;
}