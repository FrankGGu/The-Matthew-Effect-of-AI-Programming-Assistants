#include <string>
#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int findTheLongestSubstring(std::string s) {
        int max_len = 0;
        int current_mask = 0;

        // Using a vector as a hash map to store the first occurrence of each mask.
        // The mask represents the parity of vowel counts (5 bits for a, e, i, o, u).
        // Possible mask values range from 0 to 2^5 - 1 = 31.
        // Initialize all entries to -2, indicating that the mask has not been seen yet.
        // -1 is reserved for the initial state before the string starts.
        std::vector<int> first_occurrence_of_mask(32, -2);

        // The state with mask 0 (all vowels have even counts) is considered to exist
        // before the string starts, at a conceptual index of -1.
        first_occurrence_of_mask[0] = -1;

        for (int i = 0; i < s.length(); ++i) {
            char c = s[i];

            // Update the current_mask based on the vowel encountered.
            // XORing with (1 << bit_position) toggles the bit.
            if (c == 'a') {
                current_mask ^= (1 << 0); // Bit 0 for 'a'
            } else if (c == 'e') {
                current_mask ^= (1 << 1); // Bit 1 for 'e'
            } else if (c == 'i') {
                current_mask ^= (1 << 2); // Bit 2 for 'i'
            } else if (c == 'o') {
                current_mask ^= (1 << 3); // Bit 3 for 'o'
            } else if (c == 'u') {
                current_mask ^= (1 << 4); // Bit 4 for 'u'
            }

            // If this current_mask has been seen before
            if (first_occurrence_of_mask[current_mask] != -2) {
                // The substring from first_occurrence_of_mask[current_mask] + 1
                // to the current index i has all vowels in even counts.
                // The length of this substring is i - first_occurrence_of_mask[current_mask].
                max_len = std::max(max_len, i - first_occurrence_of_mask[current_mask]);
            } else {
                // If this is the first time we encounter this mask, store its index.
                first_occurrence_of_mask[current_mask] = i;
            }
        }

        return max_len;
    }
};