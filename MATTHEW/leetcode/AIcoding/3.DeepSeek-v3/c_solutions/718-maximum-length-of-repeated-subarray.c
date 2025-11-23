int findLength(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int** dp = (int**)malloc((nums1Size + 1) * sizeof(int*));
    for (int i = 0; i <= nums1Size; i++) {
        dp[i] = (int*)calloc(nums2Size + 1, sizeof(int));
    }

    int maxLength = 0;

    for (int i = nums1Size - 1; i >= 0; i--) {
        for (int j = nums2Size - 1; j >= 0; j--) {
            if (nums1[i] == nums2[j]) {
                dp[i][j] = dp[i + 1][j + 1] + 1;
                if (dp[i][j] > maxLength) {
                    maxLength = dp[i][j];
                }
            }
        }
    }

    for (int i = 0; i <= nums1Size; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLength;
}