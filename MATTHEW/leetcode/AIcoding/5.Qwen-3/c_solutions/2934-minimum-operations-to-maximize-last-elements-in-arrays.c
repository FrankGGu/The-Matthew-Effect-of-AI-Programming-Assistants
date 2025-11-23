#include <stdio.h>
#include <stdlib.h>

int maxOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int ops = 0;
    int i;

    for (i = n - 1; i >= 0; i--) {
        if (nums1[i] == nums2[i]) {
            continue;
        }
        if (nums1[i] > nums2[i]) {
            int temp = nums1[i];
            nums1[i] = nums2[i];
            nums2[i] = temp;
        }
        if (nums1[i] != nums2[i]) {
            return -1;
        }
    }

    for (i = n - 1; i >= 0; i--) {
        if (nums1[i] == nums2[i]) {
            continue;
        }
        if (nums1[i] > nums2[i]) {
            int temp = nums1[i];
            nums1[i] = nums2[i];
            nums2[i] = temp;
        }
        if (nums1[i] != nums2[i]) {
            return -1;
        }
    }

    for (i = n - 1; i >= 0; i--) {
        if (nums1[i] == nums2[i]) {
            continue;
        }
        if (nums1[i] > nums2[i]) {
            int temp = nums1[i];
            nums1[i] = nums2[i];
            nums2[i] = temp;
        }
        if (nums1[i] != nums2[i]) {
            return -1;
        }
    }

    return ops;
}