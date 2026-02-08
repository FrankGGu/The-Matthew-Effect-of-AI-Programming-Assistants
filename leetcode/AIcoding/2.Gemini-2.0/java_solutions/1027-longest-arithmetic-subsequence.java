class Solution {
    public int longestArithSeqLength(int[] nums) {
        int n = nums.length;
        if (n <= 2) {
            return n;
        }

        int maxLen = 2;
        int[][] dp = new int[n][1001]; 

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int diff = nums[j] - nums[i] + 500;
                dp[j][diff] = 2;
                for (int k = 0; k < i; k++) {
                    if (nums[i] - nums[k] + 500 == diff) {
                        dp[j][diff] = Math.max(dp[j][diff], dp[i][diff] + 1);
                    }
                }
                maxLen = Math.max(maxLen, dp[j][diff]);
            }
        }

        return maxLen;
    }
}