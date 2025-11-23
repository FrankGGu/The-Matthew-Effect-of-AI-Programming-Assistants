#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int longestAwesome(std::string s) {
        int n = s.length();

        // pos[mask] stores the first index 'j' where the prefix mask 'mask' was encountered.
        // Initialize with -1, indicating not seen yet.
        // The size is 2^10 because there are 10 digits (0-9).
        std::vector<int> pos(1 << 10, -1);

        // Initialize for an empty prefix before index 0.
        // The mask for an empty prefix is 0 (all counts are 0, which is even).
        // The "index" for this empty prefix is -1.
        pos[0] = -1;

        int current_mask = 0; // Represents the parity mask for the prefix s[0...j]
        int max_len = 0;      // Stores the maximum length found so far

        for (int j = 0; j < n; ++j) {
            int digit = s[j] - '0';

            // Toggle the bit corresponding to the current digit
            current_mask ^= (1 << digit);

            // Case 1: The substring s[i...j] has all digits appearing an even number of times.
            // This means current_mask ^ prefix_mask[i-1] == 0, so prefix_mask[i-1] == current_mask.
            if (pos[current_mask] != -1) {
                max_len = std::max(max_len, j - pos[current_mask]);
            }

            // Case 2: The substring s[i...j] has exactly one digit appearing an odd number of times.
            // This means current_mask ^ prefix_mask[i-1] == (1 << k) for some k (0-9).
            // So, prefix_mask[i-1] == current_mask ^ (1 << k).
            for (int k = 0; k < 10; ++k) {
                int target_mask = current_mask ^ (1 << k);
                if (pos[target_mask] != -1) {
                    max_len = std::max(max_len, j - pos[target_mask]);
                }
            }

            // Store the first occurrence of the current_mask.
            // We only care about the first occurrence to maximize the length (j - pos[mask]).
            if (pos[current_mask] == -1) {
                pos[current_mask] = j;
            }
        }

        return max_len;
    }
};