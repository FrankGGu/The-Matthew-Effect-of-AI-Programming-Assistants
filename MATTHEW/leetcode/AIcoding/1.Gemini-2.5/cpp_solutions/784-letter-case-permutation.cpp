#include <vector>
#include <string>
#include <cctype>

class Solution {
public:
    std::vector<std::string> letterCasePermutation(std::string s) {
        std::vector<std::string> result;
        backtrack(s, 0, result);
        return result;
    }

private:
    void backtrack(std::string& s, int current_index, std::vector<std::string>& result) {
        if (current_index == s.length()) {
            result.push_back(s);
            return;
        }

        // Option 1: Keep the character at s[current_index] as it is
        backtrack(s, current_index + 1, result);

        // Option 2: If the character is a letter, change its case and recurse
        if (std::isalpha(s[current_index])) {
            // Toggle case
            if (std::islower(s[current_index])) {
                s[current_index] = std::toupper(s[current_index]);
            } else {
                s[current_index] = std::tolower(s[current_index]);
            }

            // Recurse with the changed case
            backtrack(s, current_index + 1, result);

            // Backtrack: Restore the character to its state before this `if` block
            // (i.e., toggle it back to its original case before this specific recursive call)
            if (std::islower(s[current_index])) {
                s[current_index] = std::toupper(s[current_index]);
            } else {
                s[current_index] = std::tolower(s[current_index]);
            }
        }
    }
};