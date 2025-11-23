#include <stdio.h>
#include <stdlib.h>

int longestNonDecreasingSubarray(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int maxLen = 0;
    int i = 0, j = 0;
    int len = 0;

    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] <= nums2[j]) {
            len++;
            i++;
            j++;
        } else if (nums2[j] <= nums1[i]) {
            len++;
            i++;
            j++;
        } else {
            maxLen = (len > maxLen) ? len : maxLen;
            len = 0;
            i++;
            j++;
        }
    }

    maxLen = (len > maxLen) ? len : maxLen;
    return maxLen;
}