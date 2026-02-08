#include <vector>
#include <numeric>

class Solution {
public:
    long long triplesWithBitwiseANDEqualToZero(std::vector<int>& nums) {
        const int MAX_BITS = 16;
        const int MAX_VAL = 1 << MAX_BITS; // 2^16 = 65536

        std::vector<int> dp(MAX_VAL, 0);

        // Step 1: Populate dp array.
        // dp[x] will store the number of pairs (a, b) such that (a & b) == x.
        for (int a : nums) {
            for (int b : nums) {
                dp[a & b]++;
            }
        }

        // Step 2: Apply Sum Over Subsets (SOS) DP.
        // After this step, dp[mask] will store the sum of initial dp[submask]
        // for all submask of `mask`.
        // That is, dp[mask] = sum(count(x)) for all x that are submasks of `mask`.
        for (int i = 0; i < MAX_BITS; ++i) {
            for (int mask = 0; mask < MAX_VAL; ++mask) {
                if (mask & (1 << i)) { // If the i-th bit is set in `mask`
                    // Add the count from the submask that doesn't have the i-th bit set
                    dp[mask] += dp[mask ^ (1 << i)];
                }
            }
        }

        // Step 3: Calculate the final answer.
        // We need triples (a, b, c) such that (a & b & c) == 0.
        // Let x = (a & b). We need x & c == 0.
        // This means x must be a submask of (~c) (bitwise NOT of c, restricted to 16 bits).
        // The complement of c within 16 bits is (MAX_VAL - 1) ^ c.
        long long ans = 0;
        for (int c : nums) {
            int target_mask = (MAX_VAL - 1) ^ c; // Represents all bits that are NOT set in c
            ans += dp[target_mask]; // dp[target_mask] now contains sum of dp[x] where x is a submask of target_mask
                                    // which means x & c == 0.
        }

        return ans;
    }
};