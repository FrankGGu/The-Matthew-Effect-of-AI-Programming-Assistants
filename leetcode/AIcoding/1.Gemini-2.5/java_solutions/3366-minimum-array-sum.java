import java.util.Arrays;

class Solution {
    public long minArraySum(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        Arrays.sort(nums);

        long currentSum = 0;
        for (int i = 0; i < nums.length; i++) {
            if (i > 0 && nums[i] <= nums[i - 1]) {
                nums[i] = nums[i - 1] + 1;
            }
            currentSum += nums[i];
        }

        return currentSum;
    }
}