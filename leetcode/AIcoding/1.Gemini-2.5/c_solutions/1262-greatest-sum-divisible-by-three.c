#include <string.h> // Required for memcpy

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int maxSumDivThree(int* nums, int numsSize) {
    int dp[3];
    dp[0] = 0;
    dp[1] = -1;
    dp[2] = -1;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int next_dp[3];
        memcpy(next_dp, dp, sizeof(dp));

        for (int r = 0; r < 3; r++) {
            if (dp[r] != -1) {
                int new_sum = dp[r] + num;
                int new_rem = new_sum % 3;
                next_dp[new_rem] = max(next_dp[new_rem], new_sum);
            }
        }
        memcpy(dp, next_dp, sizeof(dp));
    }

    return dp[0];
}