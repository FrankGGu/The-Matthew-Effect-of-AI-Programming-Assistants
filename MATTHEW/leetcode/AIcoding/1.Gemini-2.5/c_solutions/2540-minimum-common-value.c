int getCommon(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int p1 = 0;
    int p2 = 0;

    while (p1 < nums1Size && p2 < nums2Size) {
        if (nums1[p1] == nums2[p2]) {
            return nums1[p1];
        } else if (nums1[p1] < nums2[p2]) {
            p1++;
        } else {
            p2++;
        }
    }

    return -1;
}