int xorAllNums(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int result = 0;
    if (nums2Size % 2 == 1) {
        for (int i = 0; i < nums1Size; i++) {
            result ^= nums1[i];
        }
    }
    if (nums1Size % 2 == 1) {
        for (int j = 0; j < nums2Size; j++) {
            result ^= nums2[j];
        }
    }
    return result;
}