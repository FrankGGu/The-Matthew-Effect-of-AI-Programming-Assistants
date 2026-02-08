#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(long long *)a - *(long long *)b);
}

long long kthSmallestProduct(int *nums1, int nums1Size, int *nums2, int nums2Size, long long k) {
    long long left = -1e10, right = 1e10;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long count = 0;
        for (int i = 0; i < nums1Size; ++i) {
            if (nums1[i] > 0) {
                long long target = mid / nums1[i];
                if (nums1[i] * target <= mid) {
                    count += upper_bound(nums2, nums2Size, target);
                }
            } else if (nums1[i] < 0) {
                long long target = mid / nums1[i];
                if (nums1[i] * target <= mid) {
                    count += nums2Size - lower_bound(nums2, nums2Size, target);
                }
            } else {
                if (mid >= 0) {
                    count += nums2Size;
                }
            }
        }
        if (count >= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}

int lower_bound(int *arr, int size, long long target) {
    int l = 0, r = size;
    while (l < r) {
        int m = l + (r - l) / 2;
        if (arr[m] < target) {
            l = m + 1;
        } else {
            r = m;
        }
    }
    return l;
}

int upper_bound(int *arr, int size, long long target) {
    int l = 0, r = size;
    while (l < r) {
        int m = l + (r - l) / 2;
        if (arr[m] <= target) {
            l = m + 1;
        } else {
            r = m;
        }
    }
    return l;
}