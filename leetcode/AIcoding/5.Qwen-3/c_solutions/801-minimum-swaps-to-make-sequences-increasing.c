#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int minSwaps(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int swap = 0;
    int no_swap = 0;

    for (int i = 1; i < nums1Size; i++) {
        int new_swap = INT_MAX;
        int new_no_swap = INT_MAX;

        if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
            new_swap = no_swap + 1;
            new_no_swap = no_swap;
        }

        if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
            new_swap = min(new_swap, swap + 1);
            new_no_swap = min(new_no_swap, swap);
        }

        swap = new_swap;
        no_swap = new_no_swap;
    }

    return min(swap, no_swap);
}