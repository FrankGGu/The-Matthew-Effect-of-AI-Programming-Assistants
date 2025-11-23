int xorAllPairings(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int xor_sum1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        xor_sum1 ^= nums1[i];
    }

    int xor_sum2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        xor_sum2 ^= nums2[i];
    }

    if (nums1Size % 2 == 0) {
        if (nums2Size % 2 == 0) {
            return 0;
        } else { // nums2Size is odd
            return xor_sum1;
        }
    } else { // nums1Size is odd
        if (nums2Size % 2 == 0) {
            return xor_sum2;
        } else { // nums2Size is odd
            return xor_sum1 ^ xor_sum2;
        }
    }
}