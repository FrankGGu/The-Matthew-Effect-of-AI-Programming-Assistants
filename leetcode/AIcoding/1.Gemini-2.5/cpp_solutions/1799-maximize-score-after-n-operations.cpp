#include <vector>
#include <numeric> // For std::gcd
#include <algorithm> // For std::max

class Solution {
public:
    int maxScore(std::vector<int>& nums) {
        int m = nums.size(); // m = 2 * n
        int n_ops = m / 2;

        std::vector<int> dp(1 << m, 0); // dp[mask] stores max score for elements in mask

        for (int mask = 0; mask < (1 << m); ++mask) {
            int bits_set = __builtin_popcount(mask);

            // If an odd number of elements are selected, this mask is invalid for forming pairs.
            if (bits_set % 2 != 0) {
                continue;
            }

            // Calculate the current operation number.
            // If `bits_set` elements are used, `bits_set / 2` pairs have been formed.
            // The next operation will be `(bits_set / 2) + 1`.
            int current_op_num = (bits_set / 2) + 1;

            // If we have already performed all n operations, we cannot perform more.
            if (current_op_num > n_ops) {
                continue;
            }

            // Find the first unused element (first 0 bit) in the current mask.
            int i = 0;
            while (i < m && ((mask >> i) & 1)) {
                i++;
            }

            // Iterate through all possible second unused elements 'j' after 'i'.
            // We only need to find two unused elements to form the next pair.
            for (int j = i + 1; j < m; ++j) {
                if (!((mask >> j) & 1)) { // If j-th element is also unused
                    // Form a pair (nums[i], nums[j])
                    int next_mask = mask | (1 << i) | (1 << j);
                    int score_gain = current_op_num * std::gcd(nums[i], nums[j]);
                    dp[next_mask] = std::max(dp[next_mask], dp[mask] + score_gain);
                }
            }
        }

        // The maximum score will be in dp[(1 << m) - 1], which represents all elements used.
        return dp[(1 << m) - 1];
    }
};