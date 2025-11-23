#include <string>

class Solution {
public:
    std::string lexicographicallySmallestString(std::string s) {
        int n = s.length();
        int start_idx = 0;

        // Find the first character that is not 'a'.
        // This marks the beginning of a potential substring to operate on.
        while (start_idx < n && s[start_idx] == 'a') {
            start_idx++;
        }

        // Case 1: All characters in the string are 'a'.
        // If start_idx reaches n, it means no character other than 'a' was found.
        // According to the problem, 'a' has no previous character, so it cannot be decremented.
        // Since we are allowed "at most one operation", and no operation can make an all-'a' string lexicographically smaller,
        // the optimal choice is to perform zero operations.
        // Thus, the string remains unchanged.
        if (start_idx == n) {
            return s;
        }

        // Case 2: A character not equal to 'a' was found at start_idx.
        // We will apply the operation starting from this index.
        // We continue decrementing characters as long as they are not 'a'
        // and we are within the string bounds.
        for (int i = start_idx; i < n; ++i) {
            if (s[i] == 'a') {
                // If we encounter an 'a', we must stop the operation for this contiguous substring.
                // An 'a' cannot be decremented, and the operation applies to a chosen non-empty substring.
                // So, the chosen substring for the operation ends at index i-1.
                break;
            }
            // Decrement the character (e.g., 'b' becomes 'a', 'c' becomes 'b').
            s[i]--;
        }

        return s;
    }
};