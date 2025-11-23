class Solution {
    public int maximumsSplicedArray(int[] nums1, int[] nums2) {
        int total1 = 0, total2 = 0, diff1 = 0, diff2 = 0;

        for (int i = 0; i < nums1.length; i++) {
            total1 += nums1[i];
            total2 += nums2[i];
            diff1 += nums2[i] - nums1[i];
            diff2 += nums1[i] - nums2[i];
        }

        return Math.max(total1 + Math.max(diff1, 0), total2 + Math.max(diff2, 0));
    }
}