class Solution {
    public int longestUnequalSubsequence(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                if (nums[i] != nums[j]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
        }
        int maxLength = 0;
        for (int length : dp) {
            maxLength = Math.max(maxLength, length);
        }
        return maxLength;
    }
}