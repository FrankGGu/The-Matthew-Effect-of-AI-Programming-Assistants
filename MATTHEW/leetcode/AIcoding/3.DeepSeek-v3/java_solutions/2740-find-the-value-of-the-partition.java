class Solution {
    public int findValueOfPartition(int[] nums) {
        Arrays.sort(nums);
        int minDiff = Integer.MAX_VALUE;
        for (int i = 1; i < nums.length; i++) {
            int diff = nums[i] - nums[i - 1];
            if (diff < minDiff) {
                minDiff = diff;
            }
        }
        return minDiff;
    }
}