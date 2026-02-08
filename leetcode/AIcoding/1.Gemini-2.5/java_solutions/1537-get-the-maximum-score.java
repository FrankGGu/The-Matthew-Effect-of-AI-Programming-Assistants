class Solution {
    public int maxSum(int[] nums1, int[] nums2) {
        long sum1 = 0;
        long sum2 = 0;
        long result = 0;
        int i = 0;
        int j = 0;
        int n1 = nums1.length;
        int n2 = nums2.length;
        long MOD = 1_000_000_007;

        while (i < n1 && j < n2) {
            if (nums1[i] < nums2[j]) {
                sum1 += nums1[i];
                i++;
            } else if (nums2[j] < nums1[i]) {
                sum2 += nums2[j];
                j++;
            } else { // nums1[i] == nums2[j]
                result = (result + Math.max(sum1, sum2) + nums1[i]) % MOD;
                sum1 = 0;
                sum2 = 0;
                i++;
                j++;
            }
        }

        while (i < n1) {
            sum1 += nums1[i];
            i++;
        }

        while (j < n2) {
            sum2 += nums2[j];
            j++;
        }

        result = (result + Math.max(sum1, sum2)) % MOD;

        return (int) result;
    }
}