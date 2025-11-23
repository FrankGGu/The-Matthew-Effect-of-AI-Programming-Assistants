class Solution {
    public int waysToSplitArray(int[] nums) {
        long total = 0, sum = 0, count = 0;
        for (int num : nums) {
            total += num;
        }
        for (int i = 0; i < nums.length - 1; i++) {
            sum += nums[i];
            if (sum >= total - sum) {
                count++;
            }
        }
        return (int) count;
    }
}