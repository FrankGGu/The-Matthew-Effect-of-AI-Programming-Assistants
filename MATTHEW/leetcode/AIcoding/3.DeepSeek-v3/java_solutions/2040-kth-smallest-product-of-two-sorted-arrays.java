class Solution {
    public long kthSmallestProduct(int[] nums1, int[] nums2, long k) {
        long left = (long) -1e10, right = (long) 1e10;
        while (left < right) {
            long mid = left + (right - left) / 2;
            long count = countLessOrEqual(nums1, nums2, mid);
            if (count < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private long countLessOrEqual(int[] nums1, int[] nums2, long target) {
        long count = 0;
        for (int num : nums1) {
            if (num == 0) {
                if (target >= 0) {
                    count += nums2.length;
                }
            } else if (num > 0) {
                count += findLessOrEqual(nums2, target / num);
            } else {
                count += findGreaterOrEqual(nums2, (long) Math.ceil((double) target / num));
            }
        }
        return count;
    }

    private int findLessOrEqual(int[] nums, long target) {
        int left = 0, right = nums.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private int findGreaterOrEqual(int[] nums, long target) {
        int left = 0, right = nums.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return nums.length - left;
    }
}