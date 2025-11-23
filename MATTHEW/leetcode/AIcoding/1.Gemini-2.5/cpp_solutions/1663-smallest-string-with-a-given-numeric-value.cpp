#include <string>
#include <algorithm> // For std::max

class Solution {
public:
    std::string getSmallestString(int n, int k) {
        std::string result(n, ' '); // Initialize string of length n

        // Iterate from left to right to build the string
        for (int i = 0; i < n; ++i) {
            // Calculate the number of characters remaining to be filled after the current position
            int remaining_len = n - 1 - i;

            // Determine the value of the character at the current position (result[i]).
            // To make the string lexicographically smallest, we want to place the smallest possible character.
            // The character's value must be at least 1 ('a').
            // It also must be large enough so that the remaining 'remaining_len' characters
            // can sum up to the remaining 'k' value.
            // The maximum sum the 'remaining_len' characters can contribute is 'remaining_len * 26' (all 'z's).
            // So, the current character must contribute at least 'k - remaining_len * 26'.
            // We take the maximum of 1 and this calculated minimum to ensure it's at least 'a'.
            int char_val = std::max(1, k - remaining_len * 26);

            // Assign the character to the result string
            result[i] = (char)('a' + char_val - 1);

            // Subtract the assigned character's value from k
            k -= char_val;
        }

        return result;
    }
};