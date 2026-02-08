#include <vector>
#include <numeric>
#include <algorithm> // For std::min and std::max

class Solution {
public:
    int minSpaceWastedKResizing(std::vector<int>& nums, int k) {
        int N = nums.size();

        // Precompute waste_val[i][j] for the segment nums[i...j].
        // The waste for a segment is calculated as (max_value_in_segment * segment_length) - sum_of_elements_in_segment.
        std::vector<std::vector<int>> waste_val(N, std::vector<int>(N));
        for (int i = 0; i < N; ++i) {
            int current_max = 0;
            int current_sum = 0;
            for (int j = i; j < N; ++j) {
                current_max = std::max(current_max, nums[j]);
                current_sum += nums[j];
                waste_val[i][j] = current_max * (j - i + 1) - current_sum;
            }
        }

        // dp[i][j] represents the minimum total space wasted for the prefix nums[0...i-1]
        // using exactly 'j' resizing operations.
        // 'i' ranges from 0 to N (number of elements considered).
        // 'j' ranges from 0 to k (number of resizes).
        // Initialize with INT_MAX to signify unreachable states.
        std::vector<std::vector<int>> dp(N + 1, std::vector<int>(k + 1, INT_MAX));

        // Base case: 0 elements considered, 0 resizes, 0 waste.
        dp[0][0] = 0;

        // Fill the DP table
        for (int i = 1; i <= N; ++i) { // Iterate through the number of elements considered (from 1 to N)
            for (int j = 0; j <= k; ++j) { // Iterate through the number of resizes (from 0 to k)
                // Constraint: The number of segments (j+1) cannot exceed the number of elements (i).
                // This means j+1 <= i, or equivalently, j <= i-1.
                if (j > i - 1) {
                    continue; // This state is invalid/unreachable as we don't have enough elements for j+1 segments.
                }

                if (j == 0) {
                    // If 0 resizes, the entire prefix nums[0...i-1] must be a single segment.
                    dp[i][j] = waste_val[0][i-1];
                } else {
                    // If j > 0 resizes, we are forming j+1 segments.
                    // The last segment is nums[p...i-1], where 'p' is its starting index.
                    // The prefix nums[0...p-1] must have been processed using j-1 resizes.
                    // 'p' can range from 0 (the last segment starts at the beginning of the prefix)
                    // to i-1 (the last segment is just the last element nums[i-1]).
                    for (int p = 0; p < i; ++p) {
                        // Check if the previous state dp[p][j-1] was reachable.
                        if (dp[p][j - 1] != INT_MAX) {
                            int current_segment_waste = waste_val[p][i - 1];
                            dp[i][j] = std::min(dp[i][j], dp[p][j - 1] + current_segment_waste);
                        }
                    }
                }
            }
        }

        // The final answer is the minimum waste for the entire array (N elements)
        // using any number of resizes from 0 up to k.
        int min_total_waste = INT_MAX;
        for (int j = 0; j <= k; ++j) {
            min_total_waste = std::min(min_total_waste, dp[N][j]);
        }

        return min_total_waste;
    }
};