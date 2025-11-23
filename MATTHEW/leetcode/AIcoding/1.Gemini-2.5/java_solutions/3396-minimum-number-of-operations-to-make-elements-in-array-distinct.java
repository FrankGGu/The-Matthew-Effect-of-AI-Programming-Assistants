import java.util.Arrays;

class Solution {
    public int minIncrementForUnique(int[] nums) {
        if (nums == null || nums.length <= 1) {
            return 0;
        }

        Arrays.sort(nums);

        int operations = 0;
        int currentExpected = nums[0];

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] < currentExpected) {
                operations += (currentExpected - nums[i]);
            } else {
                currentExpected = nums[i];
            }
            currentExpected++;
        }

        return operations;
    }
}