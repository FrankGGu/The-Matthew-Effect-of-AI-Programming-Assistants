class Solution {
    public int maxOperations(int[] nums) {
        int n = nums.length;
        Integer[][] dp = new Integer[n][n];
        return Math.max(solve(nums, 0, 1, nums[0] + nums[1], dp),
                        Math.max(solve(nums, 1, 2, nums[1] + nums[2], dp),
                                 solve(nums, 0, 2, nums[0] + nums[2], dp)));
    }

    private int solve(int[] nums, int left, int right, int target, Integer[][] dp) {
        if (left >= right || right >= nums.length) {
            return 0;
        }
        if (dp[left][right] != null) {
            return dp[left][right];
        }

        int ans = 0;
        if (nums[left] + nums[right] == target) {
            ans = Math.max(ans, 1 + solve(nums, left + 1, right - 1, target, dp));
        }
        if (left + 1 < nums.length && nums[left] + nums[left + 1] == target) {
            ans = Math.max(ans, 1 + solve(nums, left + 2, right, target, dp));
        }
        if (right - 1 >= 0 && nums[right] + nums[right - 1] == target) {
            ans = Math.max(ans, 1 + solve(nums, left, right - 2, target, dp));
        }

        return dp[left][right] = ans;
    }
}