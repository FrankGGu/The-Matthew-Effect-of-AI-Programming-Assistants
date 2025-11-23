#include <vector> // Required for std::vector

class Solution {
public:
    bool validPartition(std::vector<int>& nums) {
        int n = nums.size();

        // dp[i] will be true if the prefix nums[0...i-1] can be validly partitioned.
        // The dp array size is n+1 to handle dp[0] (empty prefix) up to dp[n] (full array).
        std::vector<bool> dp(n + 1, false);

        // Base case: an empty prefix (length 0) is considered validly partitioned.
        dp[0] = true;

        // Iterate from prefix length 1 up to n.
        for (int i = 1; i <= n; ++i) {
            // Check for a 2-element partition ending at index i-1.
            // This means nums[i-2] and nums[i-1] form a valid pair.
            // For this to be a valid partition of nums[0...i-1], the prefix nums[0...i-3]
            // must also be validly partitioned (represented by dp[i-2]).
            if (i >= 2) {
                if (nums[i-1] == nums[i-2]) {
                    dp[i] = dp[i] || dp[i-2];
                }
            }

            // Check for a 3-element partition ending at index i-1.
            // This means nums[i-3], nums[i-2], and nums[i-1] form a valid triplet.
            // For this to be a valid partition of nums[0...i-1], the prefix nums[0...i-4]
            // must also be validly partitioned (represented by dp[i-3]).
            if (i >= 3) {
                // Condition 1: three equal elements (e.g., [4,4,4])
                if (nums[i-1] == nums[i-2] && nums[i-2] == nums[i-3]) {
                    dp[i] = dp[i] || dp[i-3];
                }
                // Condition 2: three consecutive increasing elements (e.g., [5,6,7])
                if (nums[i-1] == nums[i-2] + 1 && nums[i-2] == nums[i-3] + 1) {
                    dp[i] = dp[i] || dp[i-3];
                }
            }
        }

        // The result is whether the entire array (prefix of length n) can be validly partitioned.
        return dp[n];
    }
};