import java.util.Arrays;

public class Solution {
    public int minOperations(int[] nums, int target) {
        int n = nums.length;
        Arrays.sort(nums);
        int[] dp = new int[target + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                if (dp[j - num] != Integer.MAX_VALUE) {
                    dp[j] = Math.min(dp[j], dp[j - num] + 1);
                }
            }
        }

        return dp[target] == Integer.MAX_VALUE ? -1 : dp[target];
    }
}