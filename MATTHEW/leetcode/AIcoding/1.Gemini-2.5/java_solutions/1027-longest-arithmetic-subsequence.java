class Solution {
    public int longestArithmeticSubsequence(int[] nums) {
        int n = nums.length;

        int[][] dp = new int[n][1001]; 
        int maxLen = 1; 

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                int diff = nums[i] - nums[j];
                int diff_idx = diff + 500; 

                int prevLen = dp[j][diff_idx] == 0 ? 1 : dp[j][diff_idx];

                dp[i][diff_idx] = prevLen + 1;

                maxLen = Math.max(maxLen, dp[i][diff_idx]);
            }
        }

        return maxLen;
    }
}