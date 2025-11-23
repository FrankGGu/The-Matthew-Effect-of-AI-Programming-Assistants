class Solution {
    public long countSubarrays(int[] nums, int minK, int maxK) {
        long ans = 0;
        int badIdx = -1;
        int lastMinIdx = -1;
        int lastMaxIdx = -1;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] < minK || nums[i] > maxK) {
                badIdx = i;
            }

            if (nums[i] == minK) {
                lastMinIdx = i;
            }

            if (nums[i] == maxK) {
                lastMaxIdx = i;
            }

            ans += Math.max(0, Math.min(lastMinIdx, lastMaxIdx) - badIdx);
        }

        return ans;
    }
}