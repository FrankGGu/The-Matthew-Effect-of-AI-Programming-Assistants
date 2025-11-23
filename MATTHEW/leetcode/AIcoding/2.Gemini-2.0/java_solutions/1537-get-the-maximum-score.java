class Solution {
    public int maxSum(int[] nums1, int[] nums2) {
        int n1 = nums1.length;
        int n2 = nums2.length;
        long sum1 = 0, sum2 = 0;
        int i = 0, j = 0;
        long res = 0;
        int MOD = 1000000007;

        while (i < n1 && j < n2) {
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

        while (i < n1) {
            sum1 += nums1[i++];
        }

        while (j < n2) {
            sum2 += nums2[j++];
        }

        res += Math.max(sum1, sum2);

        return (int) (res % MOD);
    }
}