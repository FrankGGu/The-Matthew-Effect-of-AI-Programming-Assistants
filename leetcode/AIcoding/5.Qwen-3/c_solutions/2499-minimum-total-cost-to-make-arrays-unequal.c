#include <stdio.h>
#include <stdlib.h>

int minTotalCost(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int totalCost = 0;
    int i = 0, j = 0;

    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] == nums2[j]) {
            totalCost += nums1[i];
            i++;
            j++;
        } else if (nums1[i] < nums2[j]) {
            i++;
        } else {
            j++;
        }
    }

    return totalCost;
}