#include <vector>
#include <deque>
#include <algorithm> // For std::max and std::min
#include <climits>   // For LLONG_MIN and LLONG_MAX

class Solution {
public:
    std::vector<long long> maxMinSumSubarrays(std::vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 0) {
            // According to typical LeetCode problem constraints, n >= 1.
            // If n=0 is possible, the problem statement would specify return values.
            // Returning {0, 0} for an empty array if no non-empty subarray sum is possible.
            return {0, 0}; 
        }

        std::vector<long long> prefix_sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        long long max_sum_overall = LLONG_MIN;
        long long min_sum_overall = LLONG_MAX;

        // Deque to store indices of prefix_sum array for finding minimum in a sliding window.
        // Used to calculate maximum subarray sum (current_sum - min_prefix_sum_in_window).
        std::deque<int> min_dq; 

        // Deque to store indices of prefix_sum array for finding maximum in a sliding window.
        // Used to calculate minimum subarray sum (current_sum - max_prefix_sum_in_window).
        std::deque<int> max_dq; 

        // Initialize deques with index 0 (corresponding to prefix_sum[0] = 0).
        // This allows considering subarrays starting from index 0.
        min_dq.push_back(0);
        max_dq.push_back(0);

        // Iterate from i = 1 to n (corresponding to prefix_sum[1] to prefix_sum[n]).
        // prefix_sum[i] represents the sum of nums[0...i-1].
        // We are looking for subarray sums nums[j...i-1], which is prefix_sum[i] - prefix_sum[j].
        // The length of this subarray is i - j. We need i - j <= k, so j >= i - k.
        // Also, j must be less than i. So j is in the range [max(0, i - k), i - 1].
        for (int i = 1; i <= n; ++i) {
            // --- For Maximum Sum Subarray ---
            // Remove indices from the front of min_dq that are outside the valid window [i-k, i-1].
            // An index `j` is too old if `j < i - k`.
            while (!min_dq.empty() && min_dq.front() < i - k) {
                min_dq.pop_front();
            }
            // If min_dq is not empty, update max_sum_overall.
            // The maximum sum ending at (i-1) with length at most k is prefix_sum[i] - prefix_sum[min_dq.front()].
            if (!min_dq.empty()) {
                max_sum_overall = std::max(max_sum_overall, prefix_sum[i] - prefix_sum[min_dq.front()]);
            }

            // Maintain min_dq in increasing order of prefix_sum values.
            // Remove elements from the back that are greater than or equal to the current prefix_sum[i].
            // This ensures that min_dq.front() always points to the minimum prefix_sum in the window.
            while (!min_dq.empty() && prefix_sum[min_dq.back()] >= prefix_sum[i]) {
                min_dq.pop_back();
            }
            min_dq.push_back(i); // Add current index to the deque.

            // --- For Minimum Sum Subarray ---
            // Remove indices from the front of max_dq that are outside the valid window [i-k, i-1].
            while (!max_dq.empty() && max_dq.front() < i - k) {
                max_dq.pop_front();
            }
            // If max_dq is not empty, update min_sum_overall.
            // The minimum sum ending at (i-1) with length at most k is prefix_sum[i] - prefix_sum[max_dq.front()].
            if (!max_dq.empty()) {
                min_sum_overall = std::min(min_sum_overall, prefix_sum[i] - prefix_sum[max_dq.front()]);
            }

            // Maintain max_dq in decreasing order of prefix_sum values.
            // Remove elements from the back that are less than or equal to the current prefix_sum[i].
            // This ensures that max_dq.front() always points to the maximum prefix_sum in the window.
            while (!max_dq.empty() && prefix_sum[max_dq.back()] <= prefix_sum[i]) {
                max_dq.pop_back();
            }
            max_dq.push_back(i); // Add current index to the deque.
        }

        return {max_sum_overall, min_sum_overall};
    }
};