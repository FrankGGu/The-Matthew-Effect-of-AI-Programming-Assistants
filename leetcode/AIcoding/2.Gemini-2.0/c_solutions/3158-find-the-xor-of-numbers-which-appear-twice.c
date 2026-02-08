#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheXORSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int xor_sum1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        xor_sum1 ^= nums1[i];
    }

    int result = 0;
    if (nums2Size % 2 == 1) {
        result = xor_sum1;
    }

    int xor_sum2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        xor_sum2 ^= nums2[i];
    }

    int final_result = 0;
    if (nums1Size % 2 == 1) {
        final_result = xor_sum2;
    }

    if (nums1Size % 2 == 1 && nums2Size % 2 == 1) {
        final_result = xor_sum1 ^ xor_sum2;
    } else if (nums1Size % 2 == 1) {
        final_result = xor_sum2;
    }
    else if (nums2Size % 2 == 1){
        final_result = xor_sum1;
    } else {
        final_result = 0;
    }

    return final_result;
}