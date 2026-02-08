#include <vector>
#include <deque>
#include <algorithm>
#include <limits>

class Solution {
public:
    int constrainedSubsetSum(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<int> dp(n);
        std::deque<int> dq; // Stores indices

        int max_overall_sum = std::numeric_limits<int>::min();

        for (int i = 0; i < n; ++i) {
            // Remove elements from the front of the deque if their index is outside the window [i-k, i-1]
            if (!dq.empty() && dq.front() < i - k) {
                dq.pop_front();
            }

            // Calculate current_max_prev_dp. If deque is empty or max_dp_value is negative,
            // we start a new subsequence, so previous sum is 0.
            int current_max_prev_dp = 0;
            if (!dq.empty()) {
                current_max_prev_dp = std::max(0, dp[dq.front()]);
            }

            // dp[i] is nums[i] plus the best possible previous sum
            dp[i] = nums[i] + current_max_prev_dp;

            // Update the overall maximum sum found so far
            max_overall_sum = std::max(max_overall_sum, dp[i]);

            // Maintain the deque in decreasing order of dp values
            // Remove elements from the back if their dp value is less than or equal to dp[i]
            while (!dq.empty() && dp[dq.back()] <= dp[i]) {
                dq.pop_back();
            }
            // Add current index to the back of the deque
            dq.push_back(i);
        }

        return max_overall_sum;
    }
};