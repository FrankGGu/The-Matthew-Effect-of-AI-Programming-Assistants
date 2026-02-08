int maxNonDecreasingLength(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int dp1 = 1, dp2 = 1;
    int res = 1;

    for (int i = 1; i < n; i++) {
        int new_dp1 = 1, new_dp2 = 1;

        if (nums1[i] >= nums1[i-1]) {
            new_dp1 = dp1 + 1;
        }
        if (nums1[i] >= nums2[i-1]) {
            new_dp1 = new_dp1 > dp2 + 1 ? new_dp1 : dp2 + 1;
        }

        if (nums2[i] >= nums2[i-1]) {
            new_dp2 = dp2 + 1;
        }
        if (nums2[i] >= nums1[i-1]) {
            new_dp2 = new_dp2 > dp1 + 1 ? new_dp2 : dp1 + 1;
        }

        dp1 = new_dp1;
        dp2 = new_dp2;

        if (dp1 > res) res = dp1;
        if (dp2 > res) res = dp2;
    }

    return res;
}