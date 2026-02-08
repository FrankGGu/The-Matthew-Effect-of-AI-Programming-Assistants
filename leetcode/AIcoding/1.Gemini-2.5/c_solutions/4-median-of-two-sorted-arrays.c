#include <stddef.h> // For size_t
#include <stdlib.h> // For NULL
#include <stdio.h>  // For debugging, can be removed
#include <math.h>   // For fmax, fmin, can be removed if using ternary ops

double findKth(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    // Ensure nums1 is the shorter array to optimize recursion depth
    if (nums1Size > nums2Size) {
        return findKth(nums2, nums2Size, nums1, nums1Size, k);
    }

    // Base cases
    if (nums1Size == 0) {
        return nums2[k - 1];
    }
    if (k == 1) {
        return (nums1[0] < nums2[0]) ? nums1[0] : nums2[0];
    }

    // Divide k into two parts
    // pa: number of elements to take from nums1 (at most k/2, and at most nums1Size)
    // pb: number of elements to take from nums2 (k - pa)
    int pa = (k / 2 < nums1Size) ? (k / 2) : nums1Size;
    int pb = k - pa;

    // Compare the elements at the partition points
    if (nums1[pa - 1] < nums2[pb - 1]) {
        // Discard the first 'pa' elements from nums1
        // and search for the (k - pa)-th element in the remaining arrays
        return findKth(nums1 + pa, nums1Size - pa, nums2, nums2Size, k - pa);
    } else if (nums1[pa - 1] > nums2[pb - 1]) {
        // Discard the first 'pb' elements from nums2
        // and search for the (k - pb)-th element in the remaining arrays
        return findKth(nums1, nums1Size, nums2 + pb, nums2Size - pb, k - pb);
    } else { // nums1[pa - 1] == nums2[pb - 1]
        // If the elements at the partition points are equal, this element is the k-th smallest.
        // This is because 'pa' elements from nums1 and 'pb' elements from nums2 are less than or equal to this value.
        // Since pa + pb = k, this value is the k-th smallest.
        return nums1[pa - 1];
    }
}

double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int totalLength = nums1Size + nums2Size;

    if (totalLength % 2 == 1) { // Odd total length
        // Median is the (totalLength / 2 + 1)-th smallest element
        return findKth(nums1, nums1Size, nums2, nums2Size, totalLength / 2 + 1);
    } else { // Even total length
        // Median is the average of the (totalLength / 2)-th and (totalLength / 2 + 1)-th smallest elements
        double mid1 = findKth(nums1, nums1Size, nums2, nums2Size, totalLength / 2);
        double mid2 = findKth(nums1, nums1Size, nums2, nums2Size, totalLength / 2 + 1);
        return (mid1 + mid2) / 2.0;
    }
}