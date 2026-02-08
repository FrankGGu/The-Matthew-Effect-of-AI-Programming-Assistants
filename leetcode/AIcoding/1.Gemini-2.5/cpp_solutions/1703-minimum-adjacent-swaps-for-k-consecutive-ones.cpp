#include <vector>
#include <numeric>
#include <algorithm>
#include <climits> // For LLONG_MAX

class Solution {
public:
    long long minMoves(std::vector<int>& nums, int k) {
        std::vector<int> ones_indices;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones_indices.push_back(i);
            }
        }

        int m = ones_indices.size();
        if (m < k) {
            return -1; // Not enough ones to form k consecutive ones
        }

        // Step 1: Create b array: b[i] = ones_indices[i] - i
        // This transforms the problem from moving elements to target positions (x, x+1, ...)
        // to moving elements (idx[i]-i) to a single target position (median).
        std::vector<long long> b(m);
        for (int i = 0; i < m; ++i) {
            b[i] = (long long)ones_indices[i] - i;
        }

        // Step 2: Create P_b array: prefix sums of b
        // Used to efficiently calculate sum of b values in a window.
        std::vector<long long> P_b(m + 1, 0);
        for (int i = 0; i < m; ++i) {
            P_b[i+1] = P_b[i] + b[i];
        }

        long long min_total_cost = LLONG_MAX;

        // Step 3: Iterate through all possible windows of k ones
        // j is the starting index in ones_indices (and b array) for the current window.
        for (int j = 0; j <= m - k; ++j) {
            // Current window of b values: b[j], ..., b[j+k-1]

            // Find the median value in the current window of b values.
            // For k elements, the median index is (k-1)/2 (0-indexed) within the window.
            // The actual index in the 'b' array is j + (k-1)/2.
            int mid_idx_in_window = (k - 1) / 2;
            long long median_val = b[j + mid_idx_in_window];

            // Calculate sum_left: sum of b values from b[j] to b[j + mid_idx_in_window - 1]
            long long sum_left = P_b[j + mid_idx_in_window] - P_b[j];
            long long count_left = mid_idx_in_window;

            // Calculate sum_right: sum of b values from b[j + mid_idx_in_window + 1] to b[j+k-1]
            long long sum_right = P_b[j + k] - P_b[j + mid_idx_in_window + 1];
            long long count_right = k - 1 - mid_idx_in_window;

            // Calculate cost_q_values: sum |b_s - median_val|
            // This is (median_val * count_left - sum_left) + (sum_right - median_val * count_right)
            long long cost_q_values = (median_val * count_left - sum_left) + (sum_right - median_val * count_right);

            // Calculate gap_reduction_cost: swaps saved by compressing zeros between ones
            // The initial cost calculation assumes no other elements.
            // However, the zeros between the chosen 'k' ones can be "swapped out" for free.
            // The number of zeros between ones_indices[j] and ones_indices[j+k-1] is
            // (ones_indices[j+k-1] - ones_indices[j]) - (k-1).
            long long gap_reduction_cost = (long long)(ones_indices[j+k-1] - ones_indices[j]) - (k-1);

            // The actual total cost for this window is cost_q_values minus the free swaps.
            long long current_total_cost = cost_q_values - gap_reduction_cost;

            // Update min_total_cost
            min_total_cost = std::min(min_total_cost, current_total_cost);
        }

        return min_total_cost;
    }
};