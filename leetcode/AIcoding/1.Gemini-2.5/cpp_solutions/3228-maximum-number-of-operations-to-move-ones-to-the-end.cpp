#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    long long maximumOperations(std::string s) {
        int n = s.length();

        // suffix_ones[i] stores the count of '1's from index i to n-1.
        // We need suffix_ones[i+1] when s[i] is '0'.
        // So, suffix_ones[n] will be 0 (base case for empty suffix).
        std::vector<int> suffix_ones(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            suffix_ones[i] = (s[i] == '1' ? 1 : 0) + suffix_ones[i + 1];
        }

        long long total_operations_cost = 0;
        // ones_in_current_block counts '1's encountered since the last '0' or the beginning of the string.
        // These are '1's that are currently grouped together and are to the left of the next '0' (if any).
        int ones_in_current_block = 0; 

        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                ones_in_current_block++;
            } else { // s[i] == '0'
                // If there are '1's accumulated before this '0', they must be moved.
                if (ones_in_current_block > 0) {
                    // Let k = ones_in_current_block.
                    // Let m = number of '1's to the right of s[i] (which is suffix_ones[i+1]).

                    // To maximize the total cost, we move the 'k' ones from left to right.
                    // When the first '1' from this block is moved, it sees 'm' ones to the right of 's[i]'
                    // PLUS (k-1) other '1's in its own block to its right.
                    // Its cost = m + (k-1).
                    // When the second '1' is moved, it sees 'm' ones to the right of 's[i]'
                    // PLUS (k-2) other '1's in its own block to its right.
                    // Its cost = m + (k-2).
                    // ...
                    // When the last '1' from this block is moved, it sees 'm' ones to the right of 's[i]'
                    // PLUS 0 other '1's in its own block to its right.
                    // Its cost = m + 0.

                    // Summing these costs:
                    // k * m (from the '1's to the right of s[i])
                    // + (k-1) + (k-2) + ... + 0 (from other '1's in the same block)
                    // The sum (k-1) + ... + 0 is k * (k - 1) / 2.

                    total_operations_cost += (long long)ones_in_current_block * suffix_ones[i + 1];
                    total_operations_cost += (long long)ones_in_current_block * (ones_in_current_block - 1) / 2;

                    // After processing this block of '1's (moving them past the '0'),
                    // reset the count for the next block of '1's that might appear.
                    ones_in_current_block = 0;
                }
            }
        }

        return total_operations_cost;
    }
};