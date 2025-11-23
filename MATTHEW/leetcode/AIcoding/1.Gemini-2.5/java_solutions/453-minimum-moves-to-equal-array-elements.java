import java.util.Arrays;

class Solution {
    public int minMoves(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        int minVal = nums[0];
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] < minVal) {
                minVal = nums[i];
            }
        }

        int moves = 0;
        for (int num : nums) {
            moves += (num - minVal);
        }

        return moves;
    }
}