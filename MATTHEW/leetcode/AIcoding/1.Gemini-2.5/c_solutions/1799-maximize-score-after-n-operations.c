#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int dp[1 << 14];

int maxScore(int* nums, int numsSize) {
    memset(dp, 0, sizeof(dp));

    for (int mask = 1; mask < (1 << numsSize); ++mask) {
        int num_elements_used = __builtin_popcount(mask);

        if (num_elements_used % 2 != 0) {
            continue;
        }

        int current_op = num_elements_used / 2;

        for (int i = 0; i < numsSize; ++i) {
            if (!((mask >> i) & 1)) {
                continue;
            }
            for (int j = i + 1; j < numsSize; ++j) {
                if (!((mask >> j) & 1)) {
                    continue;
                }

                int prev_mask = mask ^ (1 << i) ^ (1 << j);
                int current_pair_score = current_op * gcd(nums[i], nums[j]);

                if (dp[prev_mask] + current_pair_score > dp[mask]) {
                    dp[mask] = dp[prev_mask] + current_pair_score;
                }
            }
        }
    }

    return dp[(1 << numsSize) - 1];
}