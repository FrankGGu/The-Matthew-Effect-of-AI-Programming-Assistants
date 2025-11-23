class Solution {
    public int maxSum(int[] nums1, int[] nums2) {
        int MOD = 1_000_000_007;
        int i = 0, j = 0;
        long sum1 = 0, sum2 = 0;
        long res = 0;
        int m = nums1.length, n = nums2.length;

        while (i < m && j < n) {
            if (nums1[i] < nums2[j]) {
                sum1 += nums1[i++];
            } else if (nums1[i] > nums2[j]) {
                sum2 += nums2[j++];
            } else {
                res += Math.max(sum1, sum2) + nums1[i];
                sum1 = 0;
                sum2 = 0;
                i++;
                j++;
            }
        }

        while (i < m) {
            sum1 += nums1[i++];
        }

        while (j < n) {
            sum2 += nums2[j++];
        }

        res += Math.max(sum1, sum2);
        return (int)(res % MOD);
    }
}