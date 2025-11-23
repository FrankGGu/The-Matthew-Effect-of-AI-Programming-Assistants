#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size, int k){
    if (k == 0) {
        for (int i = 0; i < nums1Size; i++) {
            if (nums1[i] != nums2[i]) {
                return -1;
            }
        }
        return 0;
    }

    long long pos_sum = 0;
    long long neg_sum = 0;

    for (int i = 0; i < nums1Size; i++) {
        int diff = nums1[i] - nums2[i];

        if (diff % k != 0) {
            return -1;
        }

        if (diff > 0) {
            pos_sum += diff;
        } else if (diff < 0) {
            neg_sum += -diff;
        }
    }

    if (pos_sum != neg_sum) {
        return -1;
    }

    return pos_sum / k;
}