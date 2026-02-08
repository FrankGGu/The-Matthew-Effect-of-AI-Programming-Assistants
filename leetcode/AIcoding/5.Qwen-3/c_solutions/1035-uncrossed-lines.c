#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int dp(int* nums1, int nums1Size, int* nums2, int nums2Size, int** memo) {
    if (nums1Size == 0 || nums2Size == 0) {
        return 0;
    }
    if (memo[nums1Size][nums2Size] != -1) {
        return memo[nums1Size][nums2Size];
    }
    if (nums1[nums1Size - 1] == nums2[nums2Size - 1]) {
        memo[nums1Size][nums2Size] = 1 + dp(nums1, nums1Size - 1, nums2, nums2Size - 1, memo);
    } else {
        memo[nums1Size][nums2Size] = max(dp(nums1, nums1Size - 1, nums2, nums2Size, memo), dp(nums1, nums1Size, nums2, nums2Size - 1, memo));
    }
    return memo[nums1Size][nums2Size];
}

int maxUncrossedLines(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int** memo = (int**)malloc((nums1Size + 1) * sizeof(int*));
    for (int i = 0; i <= nums1Size; i++) {
        memo[i] = (int*)malloc((nums2Size + 1) * sizeof(int));
        for (int j = 0; j <= nums2Size; j++) {
            memo[i][j] = -1;
        }
    }
    int result = dp(nums1, nums1Size, nums2, nums2Size, memo);
    for (int i = 0; i <= nums1Size; i++) {
        free(memo[i]);
    }
    free(memo);
    return result;
}