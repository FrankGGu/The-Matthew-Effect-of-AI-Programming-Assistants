import java.util.Arrays;

class Solution {
    public long maxKelements(int[] nums, int k) {
        Arrays.sort(nums);
        long maxSum = 0;
        for (int i = 0; i < k; i++) {
            maxSum += nums[nums.length - 1 - i];
        }
        return maxSum;
    }
}