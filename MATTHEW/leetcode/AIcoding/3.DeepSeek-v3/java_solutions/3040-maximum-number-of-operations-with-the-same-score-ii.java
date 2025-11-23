class Solution {
    public int maxOperations(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return 0;
        }
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = -1;
            }
        }
        int res = 0;
        int sum1 = nums[0] + nums[1];
        int sum2 = nums[n - 2] + nums[n - 1];
        int sum3 = nums[0] + nums[n - 1];
        res = Math.max(res, helper(nums, 0, n - 1, sum1, dp));
        if (sum2 != sum1) {
            res = Math.max(res, helper(nums, 0, n - 1, sum2, dp));
        }
        if (sum3 != sum1 && sum3 != sum2) {
            res = Math.max(res, helper(nums, 0, n - 1, sum3, dp));
        }
        return res;
    }

    private int helper(int[] nums, int left, int right, int sum, int[][] dp) {
        if (left >= right) {
            return 0;
        }
        if (dp[left][right] != -1) {
            return dp[left][right];
        }
        int res = 0;
        if (nums[left] + nums[left + 1] == sum) {
            res = Math.max(res, 1 + helper(nums, left + 2, right, sum, dp));
        }
        if (nums[right - 1] + nums[right] == sum) {
            res = Math.max(res, 1 + helper(nums, left, right - 2, sum, dp));
        }
        if (nums[left] + nums[right] == sum) {
            res = Math.max(res, 1 + helper(nums, left + 1, right - 1, sum, dp));
        }
        dp[left][right] = res;
        return res;
    }
}