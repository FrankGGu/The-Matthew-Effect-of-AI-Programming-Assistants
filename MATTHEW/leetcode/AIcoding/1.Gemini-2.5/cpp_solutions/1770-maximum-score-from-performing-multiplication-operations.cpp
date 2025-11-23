#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long maximumScore(std::vector<int>& nums, std::vector<int>& multipliers) {
        int n = nums.size();
        int m = multipliers.size();

        // dp[j] will store the maximum score after 'i' operations,
        // having taken 'j' elements from the left.
        // We use a 1D DP array to optimize space, as dp[i] only depends on dp[i-1].
        // Initialize with a sufficiently small number (negative infinity).
        std::vector<long long> dp(m + 1, std::numeric_limits<long long>::min());

        // Base case: 0 operations, 0 elements taken from left, score is 0.
        dp[0] = 0;

        for (int i = 1; i <= m; ++i) { // i represents the current number of operations performed
            // new_dp will store the scores for the current 'i' operations
            std::vector<long long> new_dp(m + 1, std::numeric_limits<long long>::min());

            // Iterate through possible number of elements taken from the left
            // 'j' can range from 0 (all from right) to 'i' (all from left)
            for (int j = 0; j <= i; ++j) {
                int k = i - j; // k is the number of elements taken from the right

                // Option 1: The i-th operation took an element from the left.
                // This means 'j-1' elements were taken from the left in 'i-1' operations.
                // The element taken from nums is nums[j-1].
                if (j > 0) {
                    if (dp[j-1] != std::numeric_limits<long long>::min()) { // Check if previous state was reachable
                        new_dp[j] = std::max(new_dp[j], dp[j-1] + (long long)nums[j-1] * multipliers[i-1]);
                    }
                }

                // Option 2: The i-th operation took an element from the right.
                // This means 'j' elements were taken from the left in 'i-1' operations.
                // The element taken from nums is nums[n - k].
                if (k > 0) {
                    if (dp[j] != std::numeric_limits<long long>::min()) { // Check if previous state was reachable
                        new_dp[j] = std::max(new_dp[j], dp[j] + (long long)nums[n - k] * multipliers[i-1]);
                    }
                }
            }
            dp = new_dp; // Update dp for the next iteration
        }

        // After 'm' operations, find the maximum score among all possible 'j' values.
        long long max_score = std::numeric_limits<long long>::min();
        for (int j = 0; j <= m; ++j) {
            max_score = std::max(max_score, dp[j]);
        }

        return max_score;
    }
};