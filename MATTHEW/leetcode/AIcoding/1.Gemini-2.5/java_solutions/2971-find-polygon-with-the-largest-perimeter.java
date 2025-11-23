import java.util.Arrays;

class Solution {
    public long largestPerimeter(int[] nums) {
        Arrays.sort(nums);
        long currentSum = 0;
        for (int num : nums) {
            currentSum += num;
        }

        for (int i = nums.length - 1; i >= 2; i--) {
            if (currentSum - nums[i] > nums[i]) {
                return currentSum;
            }
            currentSum -= nums[i];
        }

        return -1;
    }
}