#include <vector>
#include <algorithm>
#include <climits> // For INT_MAX
#include <cmath>   // For std::abs

class Solution {
public:
    int minDistance(std::vector<int>& houses, int k) {
        std::sort(houses.begin(), houses.end());
        int n = houses.size();

        // Precompute cost[i][j]: minimum distance to serve houses[i...j] with one mailbox.
        // The optimal mailbox position for a contiguous segment of houses is at the median house.
        std::vector<std::vector<int>> cost(n, std::vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int mid_idx = i + (j - i) / 2;
                int median_val = houses[mid_idx];
                int current_cost = 0;
                for (int p = i; p <= j; ++p) {
                    current_cost += std::abs(houses[p] - median_val);
                }
                cost[i][j] = current_cost;
            }
        }

        // dp[j][i]: minimum total distance to serve the first 'i' houses (houses[0...i-1])
        // using 'j' mailboxes.
        // dp table size: (k+1) rows for mailboxes, (n+1) columns for houses.
        std::vector<std::vector<int>> dp(k + 1, std::vector<int>(n + 1, INT_MAX));

        // Base case: 0 mailboxes for 0 houses has 0 cost.
        dp[0][0] = 0;

        // Iterate over the number of mailboxes (from 1 to k)
        for (int j = 1; j <= k; ++j) {
            // Iterate over the number of houses considered (from 1 to n)
            for (int i = 1; i <= n; ++i) {
                // To place 'j' mailboxes for 'i' houses (houses[0...i-1]):
                // The j-th mailbox serves a segment of houses from index 'p' to 'i-1'.
                // The previous 'j-1' mailboxes must have served houses from index '0' to 'p-1'.
                // 'p' can range from 0 to 'i-1'.
                // The segment 'houses[p...i-1]' must contain at least one house, so 'p <= i-1'.
                // The segment 'houses[0...p-1]' must be able to be served by 'j-1' mailboxes.
                // This means 'p' must be at least 'j-1' (each mailbox serves at least one house).
                // So, 'p' goes from 'j-1' to 'i-1'.

                // The loop for 'p' iterates through all possible split points for the last mailbox.
                // 'p' represents the starting index of the group of houses served by the j-th mailbox.
                // The houses served by the j-th mailbox are houses[p...i-1].
                // The houses served by the previous j-1 mailboxes are houses[0...p-1].
                for (int p = 0; p < i; ++p) {
                    if (dp[j - 1][p] != INT_MAX) { // Ensure the previous state is reachable
                        dp[j][i] = std::min(dp[j][i], dp[j - 1][p] + cost[p][i - 1]);
                    }
                }
            }
        }

        // The final answer is the minimum cost to serve all 'n' houses using 'k' mailboxes.
        return dp[k][n];
    }
};