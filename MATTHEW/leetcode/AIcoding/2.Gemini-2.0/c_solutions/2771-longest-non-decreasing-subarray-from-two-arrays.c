#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int longestNonDecreasingSubarray(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int ans = 1;
    int dp1 = 1;
    int dp2 = 1;
    for (int i = 1; i < nums1Size; i++) {
        int new_dp1 = 1;
        int new_dp2 = 1;

        if (nums1[i] >= nums1[i - 1]) {
            new_dp1 = max(new_dp1, dp1 + 1);
        }
        if (nums1[i] >= nums2[i - 1]) {
            new_dp1 = max(new_dp1, dp2 + 1);
        }

        if (nums2[i] >= nums1[i - 1]) {
            new_dp2 = max(new_dp2, dp1 + 1);
        }
        if (nums2[i] >= nums2[i - 1]) {
            new_dp2 = max(new_dp2, dp2 + 1);
        }

        dp1 = new_dp1;
        dp2 = new_dp2;
        ans = max(ans, max(dp1, dp2));
    }
    return ans;
}