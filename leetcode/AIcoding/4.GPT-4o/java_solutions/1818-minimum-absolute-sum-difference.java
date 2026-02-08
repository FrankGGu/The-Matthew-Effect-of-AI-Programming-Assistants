import java.util.Arrays;

public class Solution {
    public int minAbsoluteSumDiff(int[] nums1, int[] nums2) {
        int MOD = 1000000007;
        int n = nums1.length;
        long totalDiff = 0;
        int[] sortedNums1 = nums1.clone();
        Arrays.sort(sortedNums1);
        long maxReduction = 0;

        for (int i = 0; i < n; i++) {
            totalDiff = (totalDiff + Math.abs(nums1[i] - nums2[i])) % MOD;
            int idx = Arrays.binarySearch(sortedNums1, nums2[i]);
            if (idx < 0) {
                idx = -(idx + 1);
            }
            if (idx > 0) {
                maxReduction = Math.max(maxReduction, (long) Math.abs(nums1[i] - nums2[i]) - Math.abs(sortedNums1[idx - 1] - nums2[i]));
            }
            if (idx < n) {
                maxReduction = Math.max(maxReduction, (long) Math.abs(nums1[i] - nums2[i]) - Math.abs(sortedNums1[idx] - nums2[i]));
            }
        }

        return (int) ((totalDiff - maxReduction + MOD) % MOD);
    }
}