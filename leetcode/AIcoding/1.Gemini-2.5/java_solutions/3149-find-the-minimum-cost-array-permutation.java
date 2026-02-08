import java.util.Arrays;

class Solution {
    public int findPermutationCost(int[] p) {
        int n = p.length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] == Integer.MAX_VALUE) {
                continue;
            }

            int current_i = Integer.bitCount(mask);

            if (current_i == n) {
                continue;
            }

            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) == 0) {
                    int cost_to_add = (current_i - p[j]) * (current_i - p[j]);
                    int next_mask = mask | (1 << j);
                    if (dp[mask] + cost_to_add < dp[next_mask]) {
                        dp[next_mask] = dp[mask] + cost_to_add;
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}