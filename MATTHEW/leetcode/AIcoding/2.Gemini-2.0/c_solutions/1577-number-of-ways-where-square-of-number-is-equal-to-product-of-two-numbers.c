#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numTriplets(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int count = 0;

    for (int i = 0; i < nums1Size; i++) {
        long long sq = (long long)nums1[i] * nums1[i];
        for (int j = 0; j < nums2Size; j++) {
            for (int k = j + 1; k < nums2Size; k++) {
                long long prod = (long long)nums2[j] * nums2[k];
                if (sq == prod) {
                    count++;
                }
            }
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        long long sq = (long long)nums2[i] * nums2[i];
        for (int j = 0; j < nums1Size; j++) {
            for (int k = j + 1; k < nums1Size; k++) {
                long long prod = (long long)nums1[j] * nums1[k];
                if (sq == prod) {
                    count++;
                }
            }
        }
    }

    return count;
}