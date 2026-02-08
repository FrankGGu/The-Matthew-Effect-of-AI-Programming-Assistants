#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int* dp = (int*)malloc(sizeof(int) * numsSize);
    if (dp == NULL) {
        return 0;
    }

    int maxLength = 1;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp[i] = max(dp[i], dp[j] + 1);
            }
        }
        maxLength = max(maxLength, dp[i]);
    }

    free(dp);
    return maxLength;
}