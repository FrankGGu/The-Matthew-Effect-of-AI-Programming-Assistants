class Solution {
    public int maximumsSplicedArray(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int sum1 = 0;
        int sum2 = 0;
        for (int i = 0; i < n; i++) {
            sum1 += nums1[i];
            sum2 += nums2[i];
        }

        int maxDiff1 = kadane(nums1, nums2);
        int maxDiff2 = kadane(nums2, nums1);

        return Math.max(sum1 + maxDiff2, sum2 + maxDiff1);
    }

    private int kadane(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int maxSoFar = 0;
        int currentMax = 0;
        for (int i = 0; i < n; i++) {
            currentMax += nums2[i] - nums1[i];
            if (currentMax < 0) {
                currentMax = 0;
            }
            maxSoFar = Math.max(maxSoFar, currentMax);
        }
        return maxSoFar;
    }
}