import java.util.Arrays;

class Solution {
    public int findNonMinMax(int[] nums) {
        if (nums.length < 3) {
            return -1;
        }

        Arrays.sort(nums);

        return nums[1];
    }
}