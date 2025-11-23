class Solution {
    public boolean canSortArray(int[] nums) {
        int n = nums.length;
        int[] bitCounts = new int[n];
        for (int i = 0; i < n; i++) {
            bitCounts[i] = Integer.bitCount(nums[i]);
        }

        int maxInSegment = nums[0];
        int currentBitCount = bitCounts[0];
        for (int i = 1; i < n; i++) {
            if (bitCounts[i] == currentBitCount) {
                maxInSegment = Math.max(maxInSegment, nums[i]);
            } else {
                if (nums[i] < maxInSegment) {
                    return false;
                }
                currentBitCount = bitCounts[i];
                maxInSegment = nums[i];
            }
        }
        return true;
    }
}