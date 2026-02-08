int maxDotProduct(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int dp[nums1Size + 1][nums2Size + 1];
    for (int i = 0; i <= nums1Size; i++) {
        for (int j = 0; j <= nums2Size; j++) {
            if (i == 0 || j == 0) {
                dp[i][j] = INT_MIN;
            } else {
                dp[i][j] = INT_MIN;
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j]);
                dp[i][j] = fmax(dp[i][j], dp[i][j - 1]);
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j - 1]);
                dp[i][j] = fmax(dp[i][j], nums1[i - 1] * nums2[j - 1]);
            }
        }
    }
    int result = INT_MIN;
    for (int i = 1; i <= nums1Size; i++) {
        for (int j = 1; j <= nums2Size; j++) {
            result = fmax(result, dp[i][j]);
        }
    }
    return result;
}