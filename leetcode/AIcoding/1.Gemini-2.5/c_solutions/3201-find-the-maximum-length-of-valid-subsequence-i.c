#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumLength(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int* dp = (int*)malloc(sizeof(int) * numsSize);

    int overall_max_len = 0;

    for (int i = 0; i < numsSize; ++i) {
        dp[i] = 1;
        for (int j = 0; j < i; ++j) {
            if (nums[j] == nums[i] || (nums[j] % 2 != nums[i] % 2)) {
                dp[i] = max(dp[i], dp[j] + 1);
            }
        }
        overall_max_len = max(overall_max_len, dp[i]);
    }

    free(dp);

    return overall_max_len;
}