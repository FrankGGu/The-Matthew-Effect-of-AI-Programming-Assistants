#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maximumLength(std::vector<int>& nums, int k) {
        // dp[mod][parity] stores the maximum length of a valid subsequence
        // ending with a number 'x' such that x % k == mod and x % 2 == parity.
        // parity 0 for even, 1 for odd.
        std::vector<std::vector<int>> dp(k, std::vector<int>(2, 0));
        int max_len = 0;

        for (int num : nums) {
            int current_mod = num % k;
            int current_parity = num % 2;
            int opposite_parity = 1 - current_parity;

            // Calculate the length of a subsequence ending with 'num' by extending
            // a previous subsequence that ended with (current_mod, opposite_parity).
            // If dp[current_mod][opposite_parity] is 0, it means no such subsequence
            // has been found yet, so 'num' starts a new subsequence of length 1.
            int new_len_from_extension = 1 + dp[current_mod][opposite_parity];

            // Update dp[current_mod][current_parity] with the maximum length found so far
            // that ends with (current_mod, current_parity).
            // This 'num' either extends a previous subsequence or starts a new one.
            dp[current_mod][current_parity] = std::max(dp[current_mod][current_parity], new_len_from_extension);

            // Update the overall maximum length found across all (mod, parity) pairs.
            max_len = std::max(max_len, dp[current_mod][current_parity]);
        }

        return max_len;
    }
};