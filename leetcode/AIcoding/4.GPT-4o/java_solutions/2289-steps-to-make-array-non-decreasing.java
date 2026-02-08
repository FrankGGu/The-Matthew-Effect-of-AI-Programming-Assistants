class Solution {
    public int minimumMoves(int[] nums) {
        int moves = 0;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] < nums[i - 1]) {
                int diff = nums[i - 1] - nums[i];
                moves += diff;
                nums[i] += diff;
            }
        }
        return moves;
    }
}