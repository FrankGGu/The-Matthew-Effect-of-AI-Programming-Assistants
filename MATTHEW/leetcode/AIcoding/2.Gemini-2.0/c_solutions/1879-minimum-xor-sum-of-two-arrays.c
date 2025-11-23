#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumXORSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int dp[1 << nums1Size];
    memset(dp, 0x3f, sizeof(dp));
    dp[0] = 0;

    for (int mask = 0; mask < (1 << nums1Size); mask++) {
        int i = __builtin_popcount(mask);
        if (i >= nums1Size) continue;

        for (int j = 0; j < nums1Size; j++) {
            if (!(mask & (1 << j))) {
                dp[mask | (1 << j)] = (dp[mask | (1 << j)] < dp[mask] + (nums1[i] ^ nums2[j])) ? dp[mask | (1 << j)] : dp[mask] + (nums1[i] ^ nums2[j]);
            }
        }
    }

    return dp[(1 << nums1Size) - 1];
}