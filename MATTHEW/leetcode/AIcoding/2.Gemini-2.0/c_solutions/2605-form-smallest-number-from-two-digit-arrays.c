#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int formSmallest(int* nums1, int nums1Size, int* nums2, int nums2Size){
    int min1 = 10, min2 = 10;
    for (int i = 0; i < nums1Size; i++) {
        min1 = min(min1, nums1[i]);
    }
    for (int i = 0; i < nums2Size; i++) {
        min2 = min(min2, nums2[i]);
    }

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            if (nums1[i] == nums2[j]) {
                return nums1[i];
            }
        }
    }

    if (min1 < min2) {
        return min1 * 10 + min2;
    } else {
        return min2 * 10 + min1;
    }
}