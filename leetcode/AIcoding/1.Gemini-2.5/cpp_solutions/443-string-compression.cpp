#include <vector>
#include <string>

class Solution {
public:
    int compress(std::vector<char>& chars) {
        if (chars.empty()) {
            return 0;
        }

        int write_idx = 0; // Pointer for writing compressed data
        int read_idx = 0;  // Pointer for reading original data
        int n = chars.size();

        while (read_idx < n) {
            char current_char = chars[read_idx];
            int count = 0;

            // Count occurrences of the current character
            while (read_idx < n && chars[read_idx] == current_char) {
                read_idx++;
                count++;
            }

            // Write the character
            chars[write_idx++] = current_char;

            // If count is greater than 1, convert count to string and write its digits
            if (count > 1) {
                std::string s_count = std::to_string(count);
                for (char c : s_count) {
                    chars[write_idx++] = c;
                }
            }
        }

        return write_idx;
    }
};