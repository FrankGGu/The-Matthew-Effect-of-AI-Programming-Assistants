#include <string>
#include <vector>
#include <array>

class Solution {
public:
    std::string decodeMessage(std::string key, std::string message) {
        std::array<char, 26> mapping_table;
        mapping_table.fill(0); // Initialize with 0 to indicate unmapped

        char current_target_char = 'a';
        for (char c : key) {
            if (c == ' ') {
                continue;
            }
            if (mapping_table[c - 'a'] == 0) { // If not mapped yet
                mapping_table[c - 'a'] = current_target_char;
                current_target_char++;
            }
        }

        std::string decoded_message = "";
        decoded_message.reserve(message.length()); // Pre-allocate memory

        for (char c : message) {
            if (c == ' ') {
                decoded_message += ' ';
            } else {
                decoded_message += mapping_table[c - 'a'];
            }
        }

        return decoded_message;
    }
};