#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    int longestArithmeticSubsequence(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 2) {
            return n;
        }

        // dp[i][diff] stores the length of the longest arithmetic subsequence
        // ending at index i with a common difference 'diff'.
        // The difference can range from nums[j] - nums[i] where nums[j], nums[i] are between 0 and 1000.
        // So, diff can range from 0 - 1000 = -1000 to 1000 - 0 = 1000.
        // We use an offset of 1000 to map differences to non-negative indices [0, 2000].
        // Each element itself forms an arithmetic subsequence of length 1, so initialize with 1.
        std::vector<std::vector<int>> dp(n, std::vector<int>(2001, 1));

        // The minimum length of an arithmetic subsequence is 1 (any single element).
        // Since n >= 2 is a constraint, max_len will at least be 2.
        int max_len = 1; 

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                int diff = nums[i] - nums[j];
                // Adjust diff to be a non-negative index for the dp table
                int diff_idx = diff + 1000;

                // An arithmetic subsequence ending at nums[i] with 'diff'
                // can be formed by extending an arithmetic subsequence ending at nums[j]
                // with the same 'diff'.
                // The length would be dp[j][diff_idx] + 1.
                // We take the maximum because multiple previous elements could lead to nums[i]
                // with the same difference.
                dp[i][diff_idx] = std::max(dp[i][diff_idx], dp[j][diff_idx] + 1);

                // Update the overall maximum length found so far
                max_len = std::max(max_len, dp[i][diff_idx]);
            }
        }

        return max_len;
    }
};