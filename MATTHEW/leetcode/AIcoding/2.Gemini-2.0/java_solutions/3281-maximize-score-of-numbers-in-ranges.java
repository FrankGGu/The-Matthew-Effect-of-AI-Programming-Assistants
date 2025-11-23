import java.util.Arrays;

class Solution {
    public long maximumScore(int[] nums, int[][] quantity) {
        int n = nums.length;
        int m = quantity.length;
        Arrays.sort(nums);

        Long[][] dp = new Long[m + 1][n + 1];

        for (int i = 0; i <= m; i++) {
            Arrays.fill(dp[i], null);
        }

        return solve(nums, quantity, 0, n, dp);
    }

    private long solve(int[] nums, int[][] quantity, int idx, int remaining, Long[][] dp) {
        if (idx == quantity.length) {
            return 0;
        }

        if (dp[idx][remaining] != null) {
            return dp[idx][remaining];
        }

        long ans = 0;
        for (int i = 1; i <= Math.min(remaining, quantity[idx][0]); i++) {
            long sum = 0;
            for (int j = remaining - i; j < remaining; j++) {
                sum += nums[j];
            }
            ans = Math.max(ans, sum + solve(nums, quantity, idx + 1, remaining - i, dp));
        }

        return dp[idx][remaining] = ans;
    }
}