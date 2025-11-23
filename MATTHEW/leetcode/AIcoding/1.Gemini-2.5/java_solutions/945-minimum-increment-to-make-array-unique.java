import java.util.Arrays;

class Solution {
    public int minIncrementForUnique(int[] nums) {
        Arrays.sort(nums);
        long moves = 0;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] <= nums[i - 1]) {
                long incrementNeeded = (long) nums[i - 1] - nums[i] + 1;
                moves += incrementNeeded;
                nums[i] = nums[i - 1] + 1;
            }
        }
        return (int) moves;
    }
}