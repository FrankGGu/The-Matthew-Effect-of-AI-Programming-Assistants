#include <string>
#include <algorithm> // Not strictly necessary for this specific solution, but often useful for string problems

class Solution {
public:
    // This solution assumes the problem asks to find the "largest" valid pair of adjacent identical digits.
    // For example, if "99" and "11" are both present, "99" is returned.
    // If no such pair exists, an empty string is returned.
    // This interpretation is common for problems titled "Find X" on LeetCode when multiple X's can exist.
    std::string findValidPair(std::string s) {
        char maxDigit = ' '; // Initialize with a character smaller than any digit ('0'-'9').
                             // ASCII value of ' ' (32) is less than '0' (48).

        // Iterate through the string to find adjacent identical digits.
        // The loop goes up to s.length() - 2 to ensure s[i+1] is a valid index.
        for (int i = 0; i < s.length() - 1; ++i) {
            // Check if the current character and the next character are identical.
            if (s[i] == s[i+1]) {
                // If a pair is found, check if its digit is greater than the current maximum found.
                if (s[i] > maxDigit) {
                    maxDigit = s[i]; // Update maxDigit if a larger digit pair is found.
                }
            }
        }

        // After checking all possible pairs:
        if (maxDigit == ' ') {
            // If maxDigit is still ' ', it means no valid pair was found in the string.
            return "";
        } else {
            // Otherwise, construct and return a string consisting of two occurrences of the largest digit found.
            return std::string(2, maxDigit);
        }
    }
};