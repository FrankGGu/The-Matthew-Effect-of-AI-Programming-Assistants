int maximumsSplicedArray(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < nums1Size; i++) {
        sum1 += nums1[i];
        sum2 += nums2[i];
    }

    int max1 = 0, max2 = 0;
    int diff1 = 0, diff2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        diff1 += nums2[i] - nums1[i];
        diff2 += nums1[i] - nums2[i];

        if (diff1 < 0) diff1 = 0;
        if (diff2 < 0) diff2 = 0;

        if (diff1 > max1) max1 = diff1;
        if (diff2 > max2) max2 = diff2;
    }

    int res1 = sum1 + max1;
    int res2 = sum2 + max2;

    return res1 > res2 ? res1 : res2;
}