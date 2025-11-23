class Solution {
    public int waysToSplitArray(int[] nums) {
        long total = 0, leftSum = 0;
        for (int num : nums) total += num;
        int count = 0;
        for (int i = 0; i < nums.length - 1; i++) {
            leftSum += nums[i];
            if (leftSum >= total - leftSum) count++;
        }
        return count;
    }
}