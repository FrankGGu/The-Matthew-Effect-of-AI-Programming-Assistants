class Solution {
    public int[] maxNumber(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        int m = nums2.length;
        int[] res = new int[k];
        for (int i = Math.max(0, k - m); i <= k && i <= n; ++i) {
            int[] candidate = merge(maxArray(nums1, i), maxArray(nums2, k - i), k);
            if (greater(candidate, 0, res, 0)) {
                res = candidate;
            }
        }
        return res;
    }

    private int[] merge(int[] nums1, int[] nums2, int k) {
        int[] res = new int[k];
        int i = 0, j = 0, idx = 0;
        while (i < nums1.length && j < nums2.length) {
            res[idx++] = greater(nums1, i, nums2, j) ? nums1[i++] : nums2[j++];
        }
        while (i < nums1.length) {
            res[idx++] = nums1[i++];
        }
        while (j < nums2.length) {
            res[idx++] = nums2[j++];
        }
        return res;
    }

    private boolean greater(int[] nums1, int i, int[] nums2, int j) {
        while (i < nums1.length && j < nums2.length && nums1[i] == nums2[j]) {
            i++;
            j++;
        }
        return j == nums2.length || (i < nums1.length && nums1[i] > nums2[j]);
    }

    private int[] maxArray(int[] nums, int k) {
        int[] res = new int[k];
        int j = 0;
        for (int i = 0; i < nums.length; ++i) {
            while (j > 0 && nums.length - i + j > k && nums[i] > res[j - 1]) {
                j--;
            }
            if (j < k) {
                res[j++] = nums[i];
            }
        }
        return res;
    }
}