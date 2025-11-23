#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long count(int* nums1, int nums1Size, int* nums2, int nums2Size, long long mid) {
    long long count = 0;
    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] >= 0) {
            int left = 0, right = nums2Size;
            while (left < right) {
                int m = left + (right - left) / 2;
                if ((long long)nums1[i] * nums2[m] <= mid) {
                    left = m + 1;
                } else {
                    right = m;
                }
            }
            count += left;
        } else {
            int left = 0, right = nums2Size;
            while (left < right) {
                int m = left + (right - left) / 2;
                if ((long long)nums1[i] * nums2[m] <= mid) {
                    right = m;
                } else {
                    left = m + 1;
                }
            }
            count += (nums2Size - left);
        }
    }
    return count;
}

long long kthSmallestProduct(int* nums1, int nums1Size, int* nums2, int nums2Size, long long k) {
    long long left = -1e10, right = 1e10;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        if (count(nums1, nums1Size, nums2, nums2Size, mid) < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}