double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    if (nums1Size > nums2Size) {
        return findMedianSortedArrays(nums2, nums2Size, nums1, nums1Size);
    }

    int m = nums1Size;
    int n = nums2Size;
    int left = 0, right = m;
    int halfLen = (m + n + 1) / 2;

    while (left <= right) {
        int i = (left + right) / 2;
        int j = halfLen - i;

        if (i < right && nums2[j-1] > nums1[i]) {
            left = i + 1;
        } else if (i > left && nums1[i-1] > nums2[j]) {
            right = i - 1;
        } else {
            int maxLeft = 0;
            if (i == 0) {
                maxLeft = nums2[j-1];
            } else if (j == 0) {
                maxLeft = nums1[i-1];
            } else {
                maxLeft = nums1[i-1] > nums2[j-1] ? nums1[i-1] : nums2[j-1];
            }

            if ((m + n) % 2 == 1) {
                return maxLeft;
            }

            int minRight = 0;
            if (i == m) {
                minRight = nums2[j];
            } else if (j == n) {
                minRight = nums1[i];
            } else {
                minRight = nums1[i] < nums2[j] ? nums1[i] : nums2[j];
            }

            return (maxLeft + minRight) / 2.0;
        }
    }

    return 0.0;
}