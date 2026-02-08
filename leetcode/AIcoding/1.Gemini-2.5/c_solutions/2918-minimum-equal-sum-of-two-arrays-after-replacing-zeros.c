#include <stdio.h>
#include <stdlib.h>

long long minimumEqualSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long sum1 = 0;
    int zeros1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] == 0) {
            zeros1++;
        } else {
            sum1 += nums1[i];
        }
    }

    long long sum2 = 0;
    int zeros2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] == 0) {
            zeros2++;
        } else {
            sum2 += nums2[i];
        }
    }

    long long min_possible_sum1 = sum1 + zeros1;
    long long min_possible_sum2 = sum2 + zeros2;

    if (zeros1 == 0 && zeros2 == 0) {
        if (sum1 == sum2) {
            return sum1;
        } else {
            return -1;
        }
    } else if (zeros1 == 0) { // Only nums1 has no zeros
        if (sum1 >= min_possible_sum2) {
            return sum1;
        } else {
            return -1;
        }
    } else if (zeros2 == 0) { // Only nums2 has no zeros
        if (sum2 >= min_possible_sum1) {
            return sum2;
        } else {
            return -1;
        }
    } else { // Both arrays have zeros
        long long result = min_possible_sum1 > min_possible_sum2 ? min_possible_sum1 : min_possible_sum2;
        return result;
    }
}