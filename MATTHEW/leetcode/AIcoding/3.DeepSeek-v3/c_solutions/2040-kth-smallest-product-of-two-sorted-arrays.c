int count(long long mid, int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long cnt = 0;
    for (int i = 0; i < nums1Size; i++) {
        long long x = nums1[i];
        if (x > 0) {
            long long target = mid / x;
            int left = 0, right = nums2Size - 1;
            while (left <= right) {
                int m = left + (right - left) / 2;
                if (nums2[m] <= target) {
                    left = m + 1;
                } else {
                    right = m - 1;
                }
            }
            cnt += left;
        } else if (x < 0) {
            long long target = mid / x;
            if (mid % x != 0 && target * x > mid) {
                target++;
            }
            int left = 0, right = nums2Size - 1;
            while (left <= right) {
                int m = left + (right - left) / 2;
                if (nums2[m] >= target) {
                    right = m - 1;
                } else {
                    left = m + 1;
                }
            }
            cnt += nums2Size - left;
        } else {
            if (mid >= 0) {
                cnt += nums2Size;
            }
        }
    }
    return cnt;
}

long long kthSmallestProduct(int* nums1, int nums1Size, int* nums2, int nums2Size, long long k) {
    long long left = -1e10, right = 1e10;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        if (count(mid, nums1, nums1Size, nums2, nums2Size) >= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}