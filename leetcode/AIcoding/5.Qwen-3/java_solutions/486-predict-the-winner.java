public class Solution {
    public boolean PredictTheWinner(int[] nums) {
        return dfs(nums, 0, nums.length - 1, new Integer[nums.length][nums.length]) >= 0;
    }

    private int dfs(int[] nums, int left, int right, Integer[][] memo) {
        if (left == right) {
            return nums[left];
        }
        if (memo[left][right] != null) {
            return memo[left][right];
        }
        int pickLeft = nums[left] - dfs(nums, left + 1, right, memo);
        int pickRight = nums[right] - dfs(nums, left, right - 1, memo);
        memo[left][right] = Math.max(pickLeft, pickRight);
        return memo[left][right];
    }
}