int kthSmallestProduct(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    long left = 0, right = (long)nums1[nums1Size - 1] * nums2[nums2Size - 1], res = -1;

    while (left <= right) {
        long mid = left + (right - left) / 2;
        long count = 0;
        int j = nums2Size - 1;

        for (int i = 0; i < nums1Size; i++) {
            while (j >= 0 && (long)nums1[i] * nums2[j] > mid) {
                j--;
            }
            count += j + 1;
        }

        if (count >= k) {
            res = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return res;
}