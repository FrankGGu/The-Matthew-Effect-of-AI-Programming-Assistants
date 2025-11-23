#include <stdio.h>
#include <stdlib.h>

int maxDistance(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int maxDist = 0;
    int i = 0, j = 0;
    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] > nums2[j]) {
            i++;
        } else if (nums1[i] <= nums2[j]) {
            if (i <= j) {
                maxDist = (j - i) > maxDist ? (j - i) : maxDist;
            }
            j++;
        }
    }
    return maxDist;
}