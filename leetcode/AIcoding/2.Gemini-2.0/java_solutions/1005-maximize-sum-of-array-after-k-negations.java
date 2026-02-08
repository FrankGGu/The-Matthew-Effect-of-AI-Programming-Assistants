import java.util.Arrays;

class Solution {
    public int largestSumAfterKNegations(int[] nums, int k) {
        Arrays.sort(nums);
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] < 0 && k > 0) {
                nums[i] = -nums[i];
                k--;
            }
        }
        if (k % 2 != 0) {
            Arrays.sort(nums);
            nums[0] = -nums[0];
        }
        for (int num : nums) {
            sum += num;
        }
        return sum;
    }
}