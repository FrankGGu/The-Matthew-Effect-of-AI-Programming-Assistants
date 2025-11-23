class Solution {
public:
    int addMinimum(std::string word) {
        int additions = 0;
        int expected_char_idx = 0; // 0 for 'a', 1 for 'b', 2 for 'c'

        for (char c : word) {
            int current_char_idx = c - 'a';

            if (current_char_idx == expected_char_idx) {
                // Character matches what's expected, move to the next in cycle
                expected_char_idx = (expected_char_idx + 1) % 3;
            } else if (current_char_idx > expected_char_idx) {
                // Character is ahead in the cycle (e.g., expected 'a', got 'c')
                // Add the missing characters to bridge the gap
                additions += (current_char_idx - expected_char_idx);
                // Now that the current character is "used", move to the next expected
                expected_char_idx = (current_char_idx + 1) % 3;
            } else { // current_char_idx < expected_char_idx
                // Character is "behind" in the cycle (e.g., expected 'b', got 'a')
                // This means we missed the rest of the current cycle (e.g., 'b' and 'c')
                // and the current character starts a new cycle.
                additions += (3 - expected_char_idx);
                // Now that the current character is "used" (as part of a new cycle), move to the next expected
                expected_char_idx = (current_char_idx + 1) % 3;
            }
        }

        // After iterating through the word, add any remaining characters to complete the last cycle
        additions += (3 - expected_char_idx) % 3;

        return additions;
    }
};