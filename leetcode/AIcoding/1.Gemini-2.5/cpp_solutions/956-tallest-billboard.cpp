#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int tallestBillboard(std::vector<int>& rods) {
        int total_sum = 0;
        for (int r : rods) {
            total_sum += r;
        }

        // dp[diff] stores the maximum sum of rods used for the left support,
        // such that (sum_left - sum_right) equals 'diff'.
        // The 'diff' can range from -total_sum to total_sum.
        // We use an 'offset' to map these differences to non-negative indices.
        int offset = total_sum;
        std::vector<int> dp(2 * total_sum + 1, -1); // Initialize with -1 to signify unreachable states
        dp[offset] = 0; // Initial state: 0 rods used, diff = 0, sum_left = 0

        for (int r : rods) {
            // Create a temporary copy of dp to store updates for the current rod.
            // This prevents using values updated by the current rod 'r' within the same iteration.
            std::vector<int> current_dp = dp; 

            // Iterate through all possible differences (indices in the dp array).
            for (int i = 0; i < dp.size(); ++i) {
                if (current_dp[i] == -1) { // If this state was unreachable before considering rod 'r', skip it.
                    continue;
                }

                int prev_sum_left = current_dp[i];
                // int prev_diff = i - offset; // This is not explicitly needed for updates, but good for understanding.

                // Option 1: Add rod 'r' to the left support
                // The new difference will be (prev_diff + r).
                // The new sum_left will be (prev_sum_left + r).
                int new_index_left = i + r;
                if (new_index_left < dp.size()) { // Ensure the new index is within bounds
                    dp[new_index_left] = std::max(dp[new_index_left], prev_sum_left + r);
                }

                // Option 2: Add rod 'r' to the right support
                // The new difference will be (prev_diff - r).
                // The new sum_left remains prev_sum_left (as 'r' is added to the right side).
                int new_index_right = i - r;
                if (new_index_right >= 0) { // Ensure the new index is within bounds
                    dp[new_index_right] = std::max(dp[new_index_right], prev_sum_left);
                }

                // Option 3: Don't use rod 'r' (implicitly handled as dp values from current_dp carry over if not updated)
            }
        }

        // The problem asks for the maximum height of the billboard, which means
        // sum_left == sum_right, i.e., diff = 0.
        // The value at dp[offset] stores the maximum sum_left when diff is 0.
        return dp[offset];
    }
};