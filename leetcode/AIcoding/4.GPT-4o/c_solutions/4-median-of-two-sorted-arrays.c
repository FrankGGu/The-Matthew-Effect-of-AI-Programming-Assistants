double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    if (nums1Size > nums2Size) {
        int* temp = nums1;
        nums1 = nums2;
        nums2 = temp;
        int tempSize = nums1Size;
        nums1Size = nums2Size;
        nums2Size = tempSize;
    }

    int imin = 0, imax = nums1Size, halfLen = (nums1Size + nums2Size + 1) / 2;
    while (imin <= imax) {
        int i = (imin + imax) / 2;
        int j = halfLen - i;

        if (i < nums1Size && nums2[j - 1] > nums1[i]) {
            imin = i + 1;
        } else if (i > 0 && nums1[i - 1] > nums2[j]) {
            imax = i - 1;
        } else {
            int maxLeft = 0, minRight = 0;
            if (i == 0) {
                maxLeft = nums2[j - 1];
            } else if (j == 0) {
                maxLeft = nums1[i - 1];
            } else {
                maxLeft = fmax(nums1[i - 1], nums2[j - 1]);
            }
            if ((nums1Size + nums2Size) % 2 == 1) {
                return maxLeft;
            }
            if (i == nums1Size) {
                minRight = nums2[j];
            } else if (j == nums2Size) {
                minRight = nums1[i];
            } else {
                minRight = fmin(nums1[i], nums2[j]);
            }
            return (maxLeft + minRight) / 2.0;
        }
    }
    return 0.0;
}