public class Solution {
    public int maximumsSplicedSum(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] diff1 = new int[n];
        int[] diff2 = new int[n];

        for (int i = 0; i < n; i++) {
            diff1[i] = nums1[i] - nums2[i];
            diff2[i] = nums2[i] - nums1[i];
        }

        int max1 = kadane(diff1);
        int max2 = kadane(diff2);

        int sum1 = 0;
        int sum2 = 0;

        for (int i = 0; i < n; i++) {
            sum1 += nums1[i];
            sum2 += nums2[i];
        }

        return Math.max(sum1 + max1, sum2 + max2);
    }

    private int kadane(int[] arr) {
        int maxEndingHere = 0;
        int maxSoFar = 0;

        for (int num : arr) {
            maxEndingHere = Math.max(num, maxEndingHere + num);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);
        }

        return maxSoFar;
    }
}