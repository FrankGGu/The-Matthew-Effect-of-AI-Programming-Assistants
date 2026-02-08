int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size, int x) {
    int total = 0;
    for (int i = 0; i < nums1Size; i++) total += nums1[i];
    for (int i = 0; i < nums2Size; i++) total -= nums2[i];

    if (total < 0) return -1;

    int target = total / 2;
    int dp[100001] = {0};
    dp[0] = 1;

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 100000; j >= nums1[i]; j--) {
            dp[j] |= dp[j - nums1[i]];
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        for (int j = 100000; j >= nums2[i]; j--) {
            dp[j] |= dp[j - nums2[i]];
        }
    }

    for (int i = 0; i <= 100000; i++) {
        if (dp[i] && i >= target) {
            return (total - i) / x;
        }
    }

    return -1;
}