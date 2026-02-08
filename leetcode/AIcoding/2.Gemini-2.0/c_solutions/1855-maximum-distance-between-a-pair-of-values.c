#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDistance(int* nums1, int nums1Size, int* nums2, int nums2Size){
    int max_dist = 0;
    int i = 0, j = 0;
    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] <= nums2[j]) {
            if (j - i > max_dist) {
                max_dist = j - i;
            }
            j++;
        } else {
            i++;
        }
    }
    return max_dist;
}