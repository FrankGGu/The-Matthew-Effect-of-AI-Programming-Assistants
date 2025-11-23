#include <string>
#include <algorithm> // For std::min

class Solution {
public:
    int minFlipsMonoIncr(std::string s) {
        int n = s.length();

        int total_zeros = 0;
        for (char c : s) {
            if (c == '0') {
                total_zeros++;
            }
        }

        int min_flips = total_zeros;

        int ones_in_prefix = 0;
        int zeros_in_prefix = 0;

        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                zeros_in_prefix++;
            } else { // s[i] == '1'
                ones_in_prefix++;
            }

            // Calculate flips for the current split point:
            // The string is considered as s[0...i] followed by s[i+1...n-1].
            // s[0...i] should be all '0's: requires flipping 'ones_in_prefix' '1's to '0's.
            // s[i+1...n-1] should be all '1's: requires flipping 'total_zeros - zeros_in_prefix' '0's to '1's.
            int current_flips = ones_in_prefix + (total_zeros - zeros_in_prefix);
            min_flips = std::min(min_flips, current_flips);
        }

        return min_flips;
    }
};