class Solution {
    public long kthSmallestProduct(int[] nums1, int[] nums2, int k) {
        long left = 0, right = (long) nums1[nums1.length - 1] * nums2[nums2.length - 1];
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (countLessEqual(nums1, nums2, mid) < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private int countLessEqual(int[] nums1, int[] nums2, long x) {
        int count = 0;
        for (int num1 : nums1) {
            if (num1 > 0) {
                count += binarySearch(nums2, x / num1);
            } else {
                if (x >= 0) count += nums2.length;
            }
        }
        return count;
    }

    private int binarySearch(int[] nums2, long target) {
        int left = 0, right = nums2.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums2[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}