#include <vector>
#include <algorithm>
#include <limits> // For std::numeric_limits

class Solution {
public:
    int minimumXORSum(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();

        // dp[mask] stores the minimum XOR sum achieved by pairing the first 'k' elements of nums1
        // (where 'k' is the number of set bits in 'mask') with the elements of nums2
        // whose indices are set in 'mask'.
        std::vector<int> dp(1 << n, std::numeric_limits<int>::max());

        // Base case: With an empty mask (no elements from nums2 used), the sum is 0.
        // This corresponds to pairing 0 elements from nums1.
        dp[0] = 0;

        // Iterate through all possible masks. A mask represents a subset of nums2 elements that have been used.
        for (int mask = 0; mask < (1 << n); ++mask) {
            // If dp[mask] is still its initial maximum value, it means this state is not reachable,
            // so we skip it.
            if (dp[mask] == std::numeric_limits<int>::max()) {
                continue;
            }

            // 'k' is the count of set bits in 'mask'. This 'k' also represents the index
            // of the current element in nums1 that we are trying to pair.
            // For example, if mask has 3 bits set, it means nums1[0], nums1[1], nums1[2]
            // have already been paired. So, we are now considering nums1[3].
            int k = __builtin_popcount(mask);

            // If k equals n, it means all n elements from nums1 have been paired.
            // We don't need to do any further pairing for this mask.
            if (k == n) {
                continue;
            }

            // Try to pair nums1[k] with each available element nums2[j].
            for (int j = 0; j < n; ++j) {
                // Check if nums2[j] has not been used yet (i.e., the j-th bit is not set in 'mask').
                if (!((mask >> j) & 1)) {
                    // Create a new mask by setting the j-th bit, indicating nums2[j] is now used.
                    int new_mask = mask | (1 << j);

                    // Update the minimum XOR sum for the new_mask state.
                    // The new sum is the current sum (dp[mask]) plus the XOR sum of nums1[k] and nums2[j].
                    dp[new_mask] = std::min(dp[new_mask], dp[mask] + (nums1[k] ^ nums2[j]));
                }
            }
        }

        // The final answer is dp[(1 << n) - 1]. This mask represents that all 'n' elements
        // from nums2 have been used, which implies all 'n' elements from nums1 have also been paired.
        return dp[(1 << n) - 1];
    }
};