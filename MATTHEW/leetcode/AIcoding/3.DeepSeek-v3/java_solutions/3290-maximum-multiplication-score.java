class Solution {
    public int maximumScore(int[] nums, int[] multipliers) {
        int n = nums.length;
        int m = multipliers.length;
        int[][] dp = new int[m + 1][m + 1];

        for (int i = m - 1; i >= 0; i--) {
            for (int left = i; left >= 0; left--) {
                int right = n - 1 - (i - left);
                dp[i][left] = Math.max(
                    multipliers[i] * nums[left] + dp[i + 1][left + 1],
                    multipliers[i] * nums[right] + dp[i + 1][left]
                );
            }
        }

        return dp[0][0];
    }
}