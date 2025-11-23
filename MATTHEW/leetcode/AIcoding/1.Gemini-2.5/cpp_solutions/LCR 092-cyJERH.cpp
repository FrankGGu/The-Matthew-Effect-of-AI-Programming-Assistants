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

        // min_flips stores the minimum flips required.
        // Initialize it with the cost of making the entire string '1's.
        // This corresponds to the split point before the first character (all 1s).
        int min_flips = total_zeros;

        // ones_left: count of '1's in the prefix S[0...k]
        // zeros_right: count of '0's in the suffix S[k+1...n-1]
        int ones_left = 0;
        int zeros_right = total_zeros; 

        // Iterate through the string, considering each character S[k] as the potential
        // boundary between the '0's part and the '1's part.
        // The split point is considered to be *after* S[k].
        // So, S[0...k] should be '0's, and S[k+1...n-1] should be '1's.
        for (int k = 0; k < n; ++k) {
            if (s[k] == '0') {
                zeros_right--;
            } else { // s[k] == '1'
                ones_left++;
            }

            // The flips for the current split (S[0...k] as '0's, S[k+1...n-1] as '1's)
            // is the sum of '1's in the left part and '0's in the right part.
            min_flips = std::min(min_flips, ones_left + zeros_right);
        }

        return min_flips;
    }
};