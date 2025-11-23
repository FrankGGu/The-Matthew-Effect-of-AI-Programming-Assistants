#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int numWays(int steps, int arrLen) {
        const int MOD = 1e9 + 7;

        // The maximum position we need to consider is steps / 2,
        // because if we go further, we won't have enough steps to return to index 0.
        // Also, it cannot exceed arrLen - 1.
        int max_pos = std::min(arrLen - 1, steps / 2);

        // dp_prev stores the number of ways to reach each position after (s-1) steps.
        // dp_curr stores the number of ways to reach each position after s steps.
        std::vector<int> dp_prev(max_pos + 1, 0);
        std::vector<int> dp_curr(max_pos + 1, 0);

        // Base case: After 0 steps, there is 1 way to be at position 0.
        dp_prev[0] = 1;

        // Iterate through each step
        for (int s = 1; s <= steps; ++s) {
            // Clear dp_curr for the current step
            std::fill(dp_curr.begin(), dp_curr.end(), 0);

            // Iterate through each possible position
            for (int pos = 0; pos <= max_pos; ++pos) {
                // Option 1: Stay at the current position
                dp_curr[pos] = dp_prev[pos];

                // Option 2: Move right from (pos - 1)
                if (pos > 0) {
                    dp_curr[pos] = (dp_curr[pos] + dp_prev[pos - 1]) % MOD;
                }

                // Option 3: Move left from (pos + 1)
                if (pos < max_pos) { // Check if pos + 1 is within bounds of max_pos
                    dp_curr[pos] = (dp_curr[pos] + dp_prev[pos + 1]) % MOD;
                }
            }
            // Update dp_prev for the next iteration
            dp_prev = dp_curr;
        }

        // The result is the number of ways to be at position 0 after 'steps' steps.
        return dp_prev[0];
    }
};