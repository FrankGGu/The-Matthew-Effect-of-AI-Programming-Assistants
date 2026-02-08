import java.util.Arrays;

class Solution {
    public int minAbsoluteSumDifference(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] sortedNums1 = nums1.clone();
        Arrays.sort(sortedNums1);
        long sum = 0;
        long maxDiff = 0;
        int mod = 1000000007;

        for (int i = 0; i < n; i++) {
            int diff = Math.abs(nums1[i] - nums2[i]);
            sum = (sum + diff) % mod;

            int left = 0;
            int right = n - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (sortedNums1[mid] == nums2[i]) {
                    maxDiff = Math.max(maxDiff, diff - 0);
                    break;
                } else if (sortedNums1[mid] < nums2[i]) {
                    maxDiff = Math.max(maxDiff, diff - (nums2[i] - sortedNums1[mid]));
                    left = mid + 1;
                } else {
                    maxDiff = Math.max(maxDiff, diff - (sortedNums1[mid] - nums2[i]));
                    right = mid - 1;
                }
            }
        }

        return (int) ((sum - maxDiff + mod) % mod);
    }
}