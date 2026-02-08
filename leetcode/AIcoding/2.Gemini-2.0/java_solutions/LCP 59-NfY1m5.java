import java.util.Arrays;

class Solution {
    public int minCost(int[] stones) {
        int n = stones.length;
        if (n <= 1) {
            return 0;
        }
        if (n == 2) {
            return stones[1];
        }
        Arrays.sort(stones);
        int[] dp = new int[n];
        dp[0] = 0;
        dp[1] = stones[1];
        dp[2] = stones[1] + stones[2];

        for (int i = 3; i < n; i++) {
            dp[i] = Math.min(dp[i - 1] + stones[i], dp[i - 2] + stones[0] + stones[i]);
        }

        return dp[n - 1];
    }
}