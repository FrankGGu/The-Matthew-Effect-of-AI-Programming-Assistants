import java.util.Arrays;

class Solution {
    public int longestSubsequence(int[] nums, int target) {
        int[] dp = new int[target + 1];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                if (dp[j - num] != -1) {
                    dp[j] = Math.max(dp[j], dp[j - num] + 1);
                }
            }
        }

        return dp[target];
    }
}