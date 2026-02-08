#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minSum(int* nums1, int nums1Size, int* nums2, int nums2Size){
    long long sum1 = 0, sum2 = 0;
    int zeros1 = 0, zeros2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] == 0) {
            zeros1++;
        } else {
            sum1 += nums1[i];
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] == 0) {
            zeros2++;
        } else {
            sum2 += nums2[i];
        }
    }

    if (zeros1 == 0 && sum1 < sum2 + zeros2) {
        return -1;
    }

    if (zeros2 == 0 && sum2 < sum1 + zeros1) {
        return -1;
    }

    long long val1 = sum1 + zeros1;
    long long val2 = sum2 + zeros2;

    return (val1 > val2) ? val1 : val2;
}