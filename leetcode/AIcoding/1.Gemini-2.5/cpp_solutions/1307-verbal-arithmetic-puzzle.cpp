#include <vector>
#include <string>
#include <numeric>
#include <set>
#include <map>
#include <cstring> // For memset

class Solution {
public:
    std::vector<char> unique_chars;
    int char_to_digit[26]; // Stores assigned digit for 'A' through 'Z'. -1 if unassigned.
    bool used_digits[10];   // True if digit is already used.
    bool is_leading[26];    // True if character is a leading character in any word or result.

    std::vector<std::string> words_global;
    std::string result_global;

    bool check_sum() {
        long long sum_words = 0;
        for (const std::string& word : words_global) {
            long long current_val = 0;
            for (char c : word) {
                current_val = current_val * 10 + char_to_digit[c - 'A'];
            }
            sum_words += current_val;
        }

        long long result_val = 0;
        for (char c : result_global) {
            result_val = result_val * 10 + char_to_digit[c - 'A'];
        }

        return sum_words == result_val;
    }

    bool solve(int char_idx) {
        if (char_idx == unique_chars.size()) {
            // All unique characters have been assigned digits, check if the sum is valid.
            return check_sum();
        }

        char current_char = unique_chars[char_idx];

        for (int digit = 0; digit <= 9; ++digit) {
            // Check if digit is already used
            if (used_digits[digit]) {
                continue;
            }
            // Check for leading zero constraint
            if (is_leading[current_char - 'A'] && digit == 0) {
                continue;
            }

            // Assign digit
            char_to_digit[current_char - 'A'] = digit;
            used_digits[digit] = true;

            // Recurse for the next character
            if (solve(char_idx + 1)) {
                return true;
            }

            // Backtrack: unassign digit and mark as unused
            used_digits[digit] = false;
            char_to_digit[current_char - 'A'] = -1;
        }

        return false; // No digit worked for current_char
    }

    bool isSolvable(std::vector<std::string>& words, std::string result) {
        words_global = words;
        result_global = result;

        std::set<char> unique_char_set;

        // Initialize char_to_digit to -1 (unassigned)
        std::memset(char_to_digit, -1, sizeof(char_to_digit));
        // Initialize used_digits to false (all digits available)
        std::memset(used_digits, false, sizeof(used_digits));
        // Initialize is_leading to false
        std::memset(is_leading, false, sizeof(is_leading));

        // Collect unique characters and identify leading characters
        for (const std::string& word : words) {
            for (char c : word) {
                unique_char_set.insert(c);
            }
            if (word.length() > 1) {
                is_leading[word[0] - 'A'] = true;
            }
        }

        for (char c : result) {
            unique_char_set.insert(c);
        }
        if (result.length() > 1) {
            is_leading[result[0] - 'A'] = true;
        }

        // Populate unique_chars vector from the set
        for (char c : unique_char_set) {
            unique_chars.push_back(c);
        }

        // If there are more than 10 unique characters, it's impossible
        if (unique_chars.size() > 10) {
            return false;
        }

        // Start the backtracking process
        return solve(0);
    }
};