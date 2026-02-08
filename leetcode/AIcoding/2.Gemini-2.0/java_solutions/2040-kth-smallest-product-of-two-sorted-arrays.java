class Solution {
    public long kthSmallestProduct(int[] nums1, int[] nums2, long k) {
        long low = (long) -1e10;
        long high = (long) 1e10;
        while (low < high) {
            long mid = low + (high - low) / 2;
            long count = countLessOrEqual(nums1, nums2, mid);
            if (count < k) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    private long countLessOrEqual(int[] nums1, int[] nums2, long target) {
        long count = 0;
        for (int num1 : nums1) {
            if (num1 >= 0) {
                int low = 0, high = nums2.length;
                while (low < high) {
                    int mid = low + (high - low) / 2;
                    if ((long) num1 * nums2[mid] <= target) {
                        low = mid + 1;
                    } else {
                        high = mid;
                    }
                }
                count += low;
            } else {
                int low = 0, high = nums2.length;
                while (low < high) {
                    int mid = low + (high - low) / 2;
                    if ((long) num1 * nums2[mid] <= target) {
                        high = mid;
                    } else {
                        low = mid + 1;
                    }
                }
                count += nums2.length - low;
            }
        }
        return count;
    }
}