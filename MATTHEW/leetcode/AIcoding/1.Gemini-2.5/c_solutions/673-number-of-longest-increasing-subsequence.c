#include <stdlib.h>

int findNumberOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return 1;
    }

    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* count = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; ++i) {
        dp[i] = 1;
        count[i] = 1;
    }

    int maxLength = 1;

    for (int i = 0; i < numsSize; ++i) {
        for (int j = 0; j < i; ++j) {
            if (nums[i] > nums[j]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    count[i] = count[j];
                } else if (dp[j] + 1 == dp[i]) {
                    count[i] += count[j];
                }
            }
        }
        if (dp[i] > maxLength) {
            maxLength = dp[i];
        }
    }

    int result = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (dp[i] == maxLength) {
            result += count[i];
        }
    }

    free(dp);
    free(count);

    return result;
}