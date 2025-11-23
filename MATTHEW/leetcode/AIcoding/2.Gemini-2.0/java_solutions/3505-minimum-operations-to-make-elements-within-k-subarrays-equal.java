import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, n);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] == n) continue;

            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) {
                    for (int j = i + 1; j < n; j++) {
                        if ((mask & (1 << j)) == 0) {
                            int diff = Math.abs(nums[i] - nums[j]);
                            if (diff <= k) {
                                dp[mask | (1 << i) | (1 << j)] = Math.min(dp[mask | (1 << i) | (1 << j)], dp[mask] + 1);
                            }
                        }
                    }
                    dp[mask | (1 << i)] = Math.min(dp[mask | (1 << i)], dp[mask] + 1);
                    break;
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}