import java.util.Arrays;

class Solution {
    public int findMaximumNonDecreasingLength(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        int[] last = new int[n];
        dp[0] = 1;
        last[0] = nums[0];
        int ans = 1;
        for (int i = 1; i < n; i++) {
            dp[i] = 1;
            last[i] = nums[i];
            for (int j = 0; j < i; j++) {
                if (last[j] <= nums[i]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                    last[i] = Math.min(last[i], nums[i] - last[j]);
                }
            }
            ans = Math.max(ans, dp[i]);
        }
        return ans;
    }
}