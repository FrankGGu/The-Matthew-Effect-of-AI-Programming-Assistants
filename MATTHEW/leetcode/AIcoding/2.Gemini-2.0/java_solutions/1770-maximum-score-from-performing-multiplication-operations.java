class Solution {
    public int maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length;
        int m = multipliers.length;
        int[][] dp = new int[m + 1][m + 1];

        for (int op = m - 1; op >= 0; op--) {
            for (int left = op; left >= 0; left--) {
                int right = n - 1 - (op - left);
                dp[op][left] = Math.max(nums[left] * multipliers[op] + dp[op + 1][left + 1],
                                         nums[right] * multipliers[op] + dp[op + 1][left]);
            }
        }

        return dp[0][0];
    }
}