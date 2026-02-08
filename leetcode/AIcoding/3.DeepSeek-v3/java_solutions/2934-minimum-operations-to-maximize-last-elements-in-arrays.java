class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int res = Integer.MAX_VALUE;

        // Case 1: Do not swap the last elements
        int count1 = 0;
        boolean valid1 = true;
        for (int i = 0; i < n - 1; i++) {
            if (nums1[i] > nums1[n - 1] || nums2[i] > nums2[n - 1]) {
                if (nums1[i] <= nums2[n - 1] && nums2[i] <= nums1[n - 1]) {
                    count1++;
                } else {
                    valid1 = false;
                    break;
                }
            }
        }
        if (valid1) {
            res = Math.min(res, count1);
        }

        // Case 2: Swap the last elements
        int count2 = 1;
        boolean valid2 = true;
        for (int i = 0; i < n - 1; i++) {
            if (nums1[i] > nums2[n - 1] || nums2[i] > nums1[n - 1]) {
                if (nums1[i] <= nums1[n - 1] && nums2[i] <= nums2[n - 1]) {
                    count2++;
                } else {
                    valid2 = false;
                    break;
                }
            }
        }
        if (valid2) {
            res = Math.min(res, count2);
        }

        return res == Integer.MAX_VALUE ? -1 : res;
    }
}