import java.util.Arrays;

class Solution {
    public int maximizeSum(int[] nums, int k) {
        Arrays.sort(nums);

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] < 0 && k > 0) {
                nums[i] = -nums[i];
                k--;
            } else if (nums[i] >= 0) {
                break;
            }
        }

        if (k % 2 == 1) {
            Arrays.sort(nums);
            nums[0] = -nums[0];
        }

        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        return sum;
    }
}