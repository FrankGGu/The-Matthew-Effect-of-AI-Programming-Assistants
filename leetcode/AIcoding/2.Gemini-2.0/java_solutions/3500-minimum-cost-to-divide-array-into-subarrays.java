import java.util.Arrays;

class Solution {
    public int minCost(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= i; j++) {
                int cost = k + calculateCost(nums, i - j, i - 1);
                if (dp[i - j] != Integer.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[i - j] + cost);
                }
            }
        }

        return dp[n];
    }

    private int calculateCost(int[] nums, int start, int end) {
        int[] count = new int[101];
        int duplicate = 0;
        for (int i = start; i <= end; i++) {
            count[nums[i]]++;
            if (count[nums[i]] > 1) {
                duplicate++;
            }
        }
        return duplicate;
    }
}