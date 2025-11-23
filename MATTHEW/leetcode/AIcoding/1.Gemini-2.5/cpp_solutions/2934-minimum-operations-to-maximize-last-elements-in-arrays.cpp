#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
public:
    // Helper function to calculate minimum swaps needed for a given set of target last elements.
    // Returns the number of swaps, or std::numeric_limits<int>::max() if impossible.
    int calculate_min_swaps(int n, const std::vector<int>& nums1, const std::vector<int>& nums2, int target1_last, int target2_last) {
        int swaps = 0;
        for (int i = 0; i < n - 1; ++i) {
            int current1 = nums1[i];
            int current2 = nums2[i];

            bool condition_no_swap_needed = (current1 <= target1_last && current2 <= target2_last);
            bool condition_swap_needed = (current2 <= target1_last && current1 <= target2_last);

            if (condition_no_swap_needed) {
                // No swap needed for this index
                continue;
            } else if (condition_swap_needed) {
                // Swap needed for this index
                swaps++;
            } else {
                // Impossible to satisfy conditions for this index
                return std::numeric_limits<int>::max(); // Indicate impossibility
            }
        }
        return swaps;
    }

    int minOperations(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();

        // If n is 1, no operations are needed as there are no elements before the last one.
        if (n == 1) {
            return 0;
        }

        int min_ops = std::numeric_limits<int>::max();

        // Scenario 1: The last elements (nums1[n-1], nums2[n-1]) are used as targets without swapping them.
        int ops1 = calculate_min_swaps(n, nums1, nums2, nums1[n-1], nums2[n-1]);
        if (ops1 != std::numeric_limits<int>::max()) {
            min_ops = std::min(min_ops, ops1);
        }

        // Scenario 2: The last elements (nums1[n-1], nums2[n-1]) are swapped, costing 1 operation.
        // The new target last elements become (nums2[n-1], nums1[n-1]).
        int ops2 = calculate_min_swaps(n, nums1, nums2, nums2[n-1], nums1[n-1]);
        if (ops2 != std::numeric_limits<int>::max()) {
            min_ops = std::min(min_ops, ops2 + 1);
        }

        // If min_ops is still std::numeric_limits<int>::max(), it means no solution was found.
        return (min_ops == std::numeric_limits<int>::max()) ? -1 : min_ops;
    }
};