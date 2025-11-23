class Solution {
    public int maximumsSplicedArray(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int sum1 = 0, sum2 = 0;
        for (int i = 0; i < n; i++) {
            sum1 += nums1[i];
            sum2 += nums2[i];
        }

        int max1 = 0, max2 = 0;
        int curr1 = 0, curr2 = 0;
        for (int i = 0; i < n; i++) {
            int diff = nums2[i] - nums1[i];
            curr1 += diff;
            curr2 -= diff;
            if (curr1 < 0) curr1 = 0;
            if (curr2 < 0) curr2 = 0;
            max1 = Math.max(max1, curr1);
            max2 = Math.max(max2, curr2);
        }

        return Math.max(sum1 + max1, sum2 + max2);
    }
}