#include <stdio.h>
#include <stdlib.h>

int minEqualSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int sum1 = 0, sum2 = 0;
    int count1 = 0, count2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] == 0) {
            count1++;
        } else {
            sum1 += nums1[i];
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] == 0) {
            count2++;
        } else {
            sum2 += nums2[i];
        }
    }

    if (count1 == 0 && count2 == 0) {
        return sum1 == sum2 ? sum1 : -1;
    }

    int minSum = (sum1 > sum2) ? sum1 : sum2;

    if (count1 == 0) {
        if (sum1 < sum2) {
            return -1;
        }
        return sum1;
    }

    if (count2 == 0) {
        if (sum2 < sum1) {
            return -1;
        }
        return sum2;
    }

    int required = (sum1 > sum2) ? sum1 : sum2;

    if (required - sum1 <= count1 * 9 && required - sum2 <= count2 * 9) {
        return required;
    }

    return -1;
}