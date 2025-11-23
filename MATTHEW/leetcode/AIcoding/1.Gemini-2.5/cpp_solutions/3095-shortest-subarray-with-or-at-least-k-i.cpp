#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int shortestSubarrayWithOR(std::vector<int>& nums, int k) {
        int n = nums.size();
        int min_len = n + 1; // Initialize with a value larger than any possible length

        // current_ors stores pairs of (OR_sum, start_index) for all distinct OR sums
        // of subarrays ending at (right-1).
        // The list is maintained such that start_index is decreasing, and OR_sum is non-decreasing.
        // For any given OR_sum, we store the largest possible start_index.
        std::vector<std::pair<int, int>> current_ors; 

        for (int right = 0; right < n; ++right) {
            std::vector<std::pair<int, int>> next_ors;

            // The current element itself forms a subarray ending at 'right'.
            // This will always be the first element in next_ors, having the largest start_index 'right'.
            next_ors.push_back({nums[right], right});

            // Extend previous subarrays by ORing with nums[right]
            for (const auto& p : current_ors) {
                int val = p.first;
                int start_idx = p.second;
                int new_or_val = val | nums[right];

                // If the new OR sum is different from the last one added to next_ors,
                // add it. This ensures unique OR sums.
                // Because 'current_ors' is processed from larger start_indices to smaller,
                // if a 'new_or_val' is already present in 'next_ors.back()', it means
                // a subarray starting at a larger index already achieved that OR sum.
                // We want the largest start_index for a given OR sum to minimize length.
                // So, if new_or_val is the same as next_ors.back().first, we skip,
                // as next_ors.back() already has the best (largest) start_index for that OR sum.
                if (new_or_val != next_ors.back().first) {
                    next_ors.push_back({new_or_val, start_idx});
                }
            }

            current_ors = std::move(next_ors); // Update for the next iteration (efficient move)

            // Check for subarrays ending at 'right' that satisfy the condition (OR_sum >= k)
            // Since 'current_ors' is ordered by decreasing start_index, the first element
            // that satisfies p.first >= k will have the largest start_index for this 'right'.
            // This largest start_index results in the shortest subarray length (right - p.second + 1).
            for (const auto& p : current_ors) {
                if (p.first >= k) {
                    min_len = std::min(min_len, right - p.second + 1);
                    // Since we found the shortest length for subarrays ending at 'right',
                    // we can break and move to the next 'right'.
                    break; 
                }
            }
        }

        // If min_len is still n + 1, it means no subarray satisfied the condition.
        return (min_len == n + 1) ? -1 : min_len;
    }
};