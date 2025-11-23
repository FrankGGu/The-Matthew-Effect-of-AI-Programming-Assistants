int maxDotProduct(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int dp[nums1Size + 1][nums2Size + 1];
    for (int i = 0; i <= nums1Size; i++) {
        for (int j = 0; j <= nums2Size; j++) {
            dp[i][j] = -1e9;
        }
    }

    for (int i = 1; i <= nums1Size; i++) {
        for (int j = 1; j <= nums2Size; j++) {
            int product = nums1[i - 1] * nums2[j - 1];
            dp[i][j] = product;
            if (i > 1 || j > 1) {
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j]);
                dp[i][j] = fmax(dp[i][j], dp[i][j - 1]);
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j - 1] + product);
            }
            if (i > 1 && j > 1) {
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j - 1]);
            }
        }
    }

    return dp[nums1Size][nums2Size];
}