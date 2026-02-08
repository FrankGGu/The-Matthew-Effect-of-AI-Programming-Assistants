void merge(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int i = nums1Size - 1, j = nums2Size - 1, k = nums1Size + nums2Size - 1;
    while (j >= 0) {
        if (i >= 0 && nums1[i] > nums2[j]) {
            nums1[k--] = nums1[i--];
        } else {
            nums1[k--] = nums2[j--];
        }
    }
}