import java.util.Arrays;

class Solution {
    public int minDistance(int[] houses, int k) {
        Arrays.sort(houses);
        int n = houses.length;

        // Precompute cost[i][j]: minimum cost to place 1 mailbox for houses[i...j]
        // The optimal position for a single mailbox is the median of the houses in that range.
        int[][] cost = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int medianIndex = i + (j - i) / 2; // Index of the median house
                for (int p = i; p <= j; p++) {
                    cost[i][j] += Math.abs(houses[p] - houses[medianIndex]);
                }
            }
        }

        // dp[k_num][house_idx]: minimum cost to place k_num mailboxes for houses[0...house_idx]
        // house_idx is 0-indexed, so it covers house_idx + 1 houses.
        int[][] dp = new int[k + 1][n];

        // Initialize dp table with a large value to represent unreachable states
        for (int i = 0; i <= k; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        // Base case: k_num = 1
        // To place 1 mailbox for houses[0...j], the cost is simply cost[0][j]
        for (int j = 0; j < n; j++) {
            dp[1][j] = cost[0][j];
        }

        // Fill DP table for k_num from 2 to k
        for (int k_num = 2; k_num <= k; k_num++) {
            // house_idx 'j' represents the last house (inclusive) covered by k_num mailboxes.
            // To place k_num mailboxes, we need at least k_num houses.
            // So, 'j' must be at least k_num - 1.
            for (int j = k_num - 1; j < n; j++) {
                // To calculate dp[k_num][j], we consider placing the k_num-th mailbox
                // for houses[p+1...j]. The previous k_num-1 mailboxes cover houses[0...p].
                // 'p' is the last index covered by the (k_num-1) mailboxes.

                // 'p' must be at least k_num - 2:
                // (k_num - 1) mailboxes need to cover (p + 1) houses.
                // So, (p + 1) >= (k_num - 1) => p >= k_num - 2.

                // 'p' must be less than 'j':
                // The k_num-th mailbox must cover at least houses[j], so houses[p+1] must be <= houses[j].
                // This implies p+1 <= j, or p < j.
                for (int p = k_num - 2; p < j; p++) {
                    if (dp[k_num - 1][p] != Integer.MAX_VALUE) { // Ensure the previous state is reachable
                        dp[k_num][j] = Math.min(dp[k_num][j], dp[k_num - 1][p] + cost[p + 1][j]);
                    }
                }
            }
        }

        // The final answer is the minimum cost to place 'k' mailboxes for all 'n' houses (indices 0 to n-1).
        return dp[k][n - 1];
    }
}