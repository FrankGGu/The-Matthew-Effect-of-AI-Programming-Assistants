#include <string>
#include <algorithm> // For std::max and std::min

class Solution {
public:
    int findTheLongestBalancedSubstring(std::string s) {
        int max_len = 0;
        int n = s.length();
        int i = 0;
        while (i < n) {
            // Count consecutive zeros starting from current position i
            int num_zeros = 0;
            int j = i;
            while (j < n && s[j] == '0') {
                num_zeros++;
                j++;
            }

            // Count consecutive ones immediately after the block of zeros
            int num_ones = 0;
            int k = j; // k starts where the block of zeros ended
            while (k < n && s[k] == '1') {
                num_ones++;
                k++;
            }

            // A balanced substring must have an equal number of 0s and 1s.
            // The effective number of '0's and '1's that can form pairs
            // is limited by the minimum of num_zeros and num_ones.
            // Each such pair contributes 2 to the total length.
            max_len = std::max(max_len, std::min(num_zeros, num_ones) * 2);

            // Move the main pointer i to the position after the current block of ones.
            // This ensures we continue searching for new balanced substrings from
            // the next unprocessed character.
            i = k;
        }
        return max_len;
    }
};