class Solution {
    public long kthSmallestProduct(int[] nums1, int[] nums2, long k) {
        long low = -10_000_000_000L - 1; 
        long high = 10_000_000_000L + 1; 
        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (countLessEqual(nums1, nums2, mid) >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private long countLessEqual(int[] nums1, int[] nums2, long target) {
        long count = 0;
        for (int num1_val : nums1) {
            if (num1_val == 0) {
                if (target >= 0) {
                    count += nums2.length;
                }
            } else if (num1_val > 0) {
                int left = 0, right = nums2.length - 1;
                int current_upper_bound_idx = -1; 
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if ((long)nums2[mid] * num1_val <= target) {
                        current_upper_bound_idx = mid;
                        left = mid + 1;
                    } else {
                        right = mid - 1;
                    }
                }
                count += (current_upper_bound_idx + 1);
            } else { // num1_val < 0
                int left = 0, right = nums2.length - 1;
                int current_lower_bound_idx = nums2.length; 
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if ((long)nums2[mid] * num1_val <= target) {
                        current_lower_bound_idx = mid;
                        right = mid - 1;
                    } else {
                        left = mid + 1;
                    }
                }
                count += (nums2.length - current_lower_bound_idx);
            }
        }
        return count;
    }
}