int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    if (k == 0) {
        for (int i = 0; i < nums1Size; i++) {
            if (nums1[i] != nums2[i]) {
                return -1;
            }
        }
        return 0;
    }

    long long pos = 0, neg = 0;
    for (int i = 0; i < nums1Size; i++) {
        long long diff = (long long)nums1[i] - nums2[i];
        if (diff % k != 0) {
            return -1;
        }
        long long steps = diff / k;
        if (steps > 0) {
            pos += steps;
        } else {
            neg += steps;
        }
    }

    if (pos + neg != 0) {
        return -1;
    }

    return pos;
}