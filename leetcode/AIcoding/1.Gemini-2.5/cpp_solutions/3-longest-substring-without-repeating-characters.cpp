#include <string>
#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int lengthOfLongestSubstring(std::string s) {
        if (s.empty()) {
            return 0;
        }

        std::vector<int> char_index(128, -1); // Stores the last seen index of each character (ASCII)
        int max_length = 0;
        int left = 0; // Left pointer of the sliding window

        for (int right = 0; right < s.length(); ++right) {
            char current_char = s[right];

            // If the current character was seen before within the current window (i.e., its last_seen_index >= left)
            if (char_index[current_char] != -1 && char_index[current_char] >= left) {
                // Move the left pointer to the position after the last occurrence of the repeating character
                left = char_index[current_char] + 1;
            }

            // Update the last seen index of the current character
            char_index[current_char] = right;

            // Calculate the current window length and update max_length
            max_length = std::max(max_length, right - left + 1);
        }

        return max_length;
    }
};