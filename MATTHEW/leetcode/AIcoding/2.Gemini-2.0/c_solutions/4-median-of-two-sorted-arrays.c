#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    if (nums1Size > nums2Size) {
        return findMedianSortedArrays(nums2, nums2Size, nums1, nums1Size);
    }

    int m = nums1Size;
    int n = nums2Size;
    int low = 0;
    int high = m;

    while (low <= high) {
        int partitionX = (low + high) / 2;
        int partitionY = (m + n + 1) / 2 - partitionX;

        int maxLeftX = (partitionX == 0) ? -2147483648 : nums1[partitionX - 1];
        int minRightX = (partitionX == m) ? 2147483647 : nums1[partitionX];

        int maxLeftY = (partitionY == 0) ? -2147483648 : nums2[partitionY - 1];
        int minRightY = (partitionY == n) ? 2147483647 : nums2[partitionY];

        if (maxLeftX <= minRightY && maxLeftY <= minRightX) {
            if ((m + n) % 2 == 0) {
                return (double)(fmax(maxLeftX, maxLeftY) + fmin(minRightX, minRightY)) / 2.0;
            } else {
                return (double)fmax(maxLeftX, maxLeftY);
            }
        } else if (maxLeftX > minRightY) {
            high = partitionX - 1;
        } else {
            low = partitionX + 1;
        }
    }

    return 0.0;
}