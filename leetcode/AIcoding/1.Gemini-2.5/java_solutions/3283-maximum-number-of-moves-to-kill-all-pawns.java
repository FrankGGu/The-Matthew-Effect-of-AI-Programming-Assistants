import java.util.Arrays;

class Solution {
    public int maximumMoves(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        int[] dp = new int[n];

        dp[0] = 1;

        int maxPawnsKilled = 1;

        for (int i = 1; i < n; i++) {
            dp[i] = 0; 

            for (int k = 0; k < i; k++) {
                if (dp[k] > 0 && nums[i] % nums[k] == 0) {
                    dp[i] = Math.max(dp[i], dp[k] + 1);
                }
            }
            maxPawnsKilled = Math.max(maxPawnsKilled, dp[i]);
        }

        return maxPawnsKilled;
    }
}