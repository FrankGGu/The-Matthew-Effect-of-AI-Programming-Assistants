#include <stdio.h>
#include <stdlib.h>

int xorAllElements(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int result = 0;
    for (int i = 0; i < nums1Size; ++i) {
        for (int j = 0; j < nums2Size; ++j) {
            result ^= nums1[i] ^ nums2[j];
        }
    }
    return result;
}