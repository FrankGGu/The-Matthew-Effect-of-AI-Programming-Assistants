#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int findLength(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int** dp = (int**)malloc((nums1Size + 1) * sizeof(int*));
    for (int i = 0; i <= nums1Size; i++) {
        dp[i] = (int*)malloc((nums2Size + 1) * sizeof(int));
        for (int j = 0; j <= nums2Size; j++) {
            dp[i][j] = 0;
        }
    }

    int maxLen = 0;

    for (int i = 1; i <= nums1Size; i++) {
        for (int j = 1; j <= nums2Size; j++) {
            if (nums1[i - 1] == nums2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
                maxLen = max(maxLen, dp[i][j]);
            } else {
                dp[i][j] = 0;
            }
        }
    }

    for (int i = 0; i <= nums1Size; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen;
}