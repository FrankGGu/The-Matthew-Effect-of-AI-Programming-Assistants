class Solution {
    public long countSubarrays(int[] nums, int minK, int maxK) {
        long count = 0;
        int left = 0, lastBad = -1, minPos = -1, maxPos = -1;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] < minK || nums[i] > maxK) {
                left = i + 1;
                lastBad = i;
            }
            if (nums[i] == minK) {
                minPos = i;
            }
            if (nums[i] == maxK) {
                maxPos = i;
            }
            count += Math.max(0, Math.min(minPos, maxPos) - lastBad);
        }
        return count;
    }
}