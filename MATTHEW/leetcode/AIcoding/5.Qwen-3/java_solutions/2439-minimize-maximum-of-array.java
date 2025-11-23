public class Solution {
    public int minimizeArrayValue(int[] nums) {
        long prefixSum = 0;
        int result = 0;
        for (int i = 0; i < nums.length; ++i) {
            prefixSum += nums[i];
            int currentAverage = (int) ((prefixSum + i) / (i + 1));
            result = Math.max(result, currentAverage);
        }
        return result;
    }
}