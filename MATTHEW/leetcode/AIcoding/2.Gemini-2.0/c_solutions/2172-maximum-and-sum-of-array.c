#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxANDSum(int* nums, int numsSize, int numSlots) {
    int dp[1 << (2 * numSlots)];
    memset(dp, -1, sizeof(dp));

    int totalSlots = 2 * numSlots;

    int solve(int mask, int index) {
        if (index == numsSize) {
            return 0;
        }

        if (dp[mask] != -1) {
            return dp[mask];
        }

        int max_sum = 0;
        for (int i = 0; i < numSlots; i++) {
            int slot_index1 = i * 2;
            int slot_index2 = i * 2 + 1;

            if (!((mask >> slot_index1) & 1)) {
                max_sum = fmax(max_sum, (nums[index] & (i + 1)) + solve(mask | (1 << slot_index1), index + 1));
            } else if (!((mask >> slot_index2) & 1)) {
                max_sum = fmax(max_sum, (nums[index] & (i + 1)) + solve(mask | (1 << slot_index2), index + 1));
            }
        }

        return dp[mask] = max_sum;
    }

    return solve(0, 0);
}