#include <stddef.h>

long long minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    if (k == 0) {
        for (int i = 0; i < nums1Size; ++i) {
            if (nums1[i] != nums2[i]) {
                return -1;
            }
        }
        return 0;
    }

    long long total_diff = 0;
    long long pos_diff_sum = 0;

    for (int i = 0; i < nums1Size; ++i) {
        long long diff_i = (long long)nums1[i] - nums2[i];

        if (diff_i % k != 0) {
            return -1;
        }

        total_diff += diff_i;

        if (diff_i > 0) {
            pos_diff_sum += diff_i;
        }
    }

    if (total_diff != 0) {
        return -1;
    }

    return pos_diff_sum / k;
}