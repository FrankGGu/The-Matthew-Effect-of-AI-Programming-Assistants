import java.util.Arrays;

class Solution {
    public int minAbsoluteSumDiff(int[] nums1, int[] nums2) {
        int n = nums1.length;
        long totalSum = 0;
        long maxReduction = 0;
        long MOD = 1_000_000_007;

        int[] sortedNums1 = new int[n];
        System.arraycopy(nums1, 0, sortedNums1, 0, n);
        Arrays.sort(sortedNums1);

        for (int i = 0; i < n; i++) {
            long currentDiff = Math.abs((long)nums1[i] - nums2[i]);
            totalSum = (totalSum + currentDiff);

            int target = nums2[i];
            int idx = Arrays.binarySearch(sortedNums1, target);

            long minNewDiff = Long.MAX_VALUE;
            if (idx >= 0) {
                minNewDiff = 0;
            } else {
                int insertionPoint = -idx - 1;
                if (insertionPoint < n) {
                    minNewDiff = Math.min(minNewDiff, Math.abs((long)sortedNums1[insertionPoint] - target));
                }
                if (insertionPoint > 0) {
                    minNewDiff = Math.min(minNewDiff, Math.abs((long)sortedNums1[insertionPoint - 1] - target));
                }
            }
            maxReduction = Math.max(maxReduction, currentDiff - minNewDiff);
        }

        return (int)((totalSum - maxReduction) % MOD);
    }
}