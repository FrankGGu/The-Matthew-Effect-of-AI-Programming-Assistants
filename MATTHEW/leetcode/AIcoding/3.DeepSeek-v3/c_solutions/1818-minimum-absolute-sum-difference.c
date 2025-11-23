int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int minAbsoluteSumDiff(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int mod = 1000000007;
    int *sorted = (int*)malloc(nums1Size * sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        sorted[i] = nums1[i];
    }
    qsort(sorted, nums1Size, sizeof(int), cmp);

    long total = 0;
    int max_reduction = 0;

    for (int i = 0; i < nums1Size; i++) {
        int diff = abs(nums1[i] - nums2[i]);
        total = (total + diff) % mod;

        int left = 0, right = nums1Size - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sorted[mid] < nums2[i]) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        int candidate;
        if (left < nums1Size) {
            candidate = abs(sorted[left] - nums2[i]);
            if (candidate < diff && diff - candidate > max_reduction) {
                max_reduction = diff - candidate;
            }
        }
        if (left > 0) {
            candidate = abs(sorted[left - 1] - nums2[i]);
            if (candidate < diff && diff - candidate > max_reduction) {
                max_reduction = diff - candidate;
            }
        }
    }

    free(sorted);
    return (total - max_reduction + mod) % mod;
}