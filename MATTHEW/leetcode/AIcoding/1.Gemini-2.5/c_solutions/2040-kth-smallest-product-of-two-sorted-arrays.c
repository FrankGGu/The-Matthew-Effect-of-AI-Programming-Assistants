int get_upper_bound_idx(int* arr, int size, long long target) {
    int low = 0, high = size - 1, ans = size;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] > target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int get_lower_bound_idx(int* arr, int size, long long target) {
    int low = 0, high = size - 1, ans = size;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

long long count_le(int* nums1, int nums1Size, int* nums2, int nums2Size, long long val) {
    long long total_count = 0;
    for (int i = 0; i < nums1Size; ++i) {
        long long x = nums1[i];
        if (x == 0) {
            if (val >= 0) {
                total_count += nums2Size;
            }
        } else if (x > 0) {
            total_count += get_upper_bound_idx(nums2, nums2Size, val / x);
        } else { // x < 0
            long long target_y_for_ceil;
            if (val >= 0) {
                target_y_for_ceil = val / x;
            } else {
                if (val % x != 0) {
                    target_y_for_ceil = (val / x) + 1;
                } else {
                    target_y_for_ceil = val / x;
                }
            }
            total_count += (nums2Size - get_lower_bound_idx(nums2, nums2Size, target_y_for_ceil));
        }
    }
    return total_count;
}

long long kthSmallestProduct(int* nums1, int nums1Size, int* nums2, int nums2Size, long long k) {
    long long low = -10000000000LL;
    long long high = 10000000000LL;
    long long ans = high;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (count_le(nums1, nums1Size, nums2, nums2Size, mid) >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}