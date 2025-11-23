#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDotProduct(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int dp[nums1Size + 1][nums2Size + 1];

    for (int i = 0; i <= nums1Size; i++) {
        for (int j = 0; j <= nums2Size; j++) {
            dp[i][j] = INT_MIN;
        }
    }

    for (int i = 1; i <= nums1Size; i++) {
        for (int j = 1; j <= nums2Size; j++) {
            dp[i][j] = nums1[i - 1] * nums2[j - 1];
            if (dp[i - 1][j] != INT_MIN) {
                dp[i][j] = (dp[i][j] > dp[i - 1][j]) ? dp[i][j] : dp[i - 1][j];
            }
            if (dp[i][j - 1] != INT_MIN) {
                dp[i][j] = (dp[i][j] > dp[i][j - 1]) ? dp[i][j] : dp[i][j - 1];
            }
            if (dp[i - 1][j - 1] != INT_MIN) {
                int temp = dp[i - 1][j - 1] + nums1[i - 1] * nums2[j - 1];
                dp[i][j] = (dp[i][j] > temp) ? dp[i][j] : temp;
            }
        }
    }

    return dp[nums1Size][nums2Size];
}