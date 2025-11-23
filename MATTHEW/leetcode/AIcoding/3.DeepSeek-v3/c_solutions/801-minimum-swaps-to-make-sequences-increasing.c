int minSwap(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int keep = 0, swap = 1;

    for (int i = 1; i < n; i++) {
        int new_keep = n, new_swap = n;

        if (nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1]) {
            new_keep = fmin(new_keep, keep);
            new_swap = fmin(new_swap, swap + 1);
        }

        if (nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1]) {
            new_keep = fmin(new_keep, swap);
            new_swap = fmin(new_swap, keep + 1);
        }

        keep = new_keep;
        swap = new_swap;
    }

    return fmin(keep, swap);
}