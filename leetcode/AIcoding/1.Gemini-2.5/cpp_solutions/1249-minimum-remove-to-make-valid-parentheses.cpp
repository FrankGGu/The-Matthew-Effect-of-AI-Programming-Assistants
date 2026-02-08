#include <string>
#include <vector>
#include <stack>

class Solution {
public:
    std::string minRemoveToMakeValid(std::string s) {
        // Create a boolean vector to mark characters that should be kept.
        // Initially, assume all characters are to be kept.
        std::vector<bool> to_keep(s.length(), true); 

        // Use a stack to keep track of the indices of open parentheses.
        std::stack<int> open_paren_indices;

        // First pass: Identify invalid closing parentheses and mark them for removal.
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '(') {
                // If an open parenthesis, push its index onto the stack.
                open_paren_indices.push(i);
            } else if (s[i] == ')') {
                // If a closing parenthesis:
                if (!open_paren_indices.empty()) {
                    // If there's an unmatched open parenthesis, they form a valid pair.
                    // Pop the index of the matching open parenthesis.
                    open_paren_indices.pop(); 
                } else {
                    // If the stack is empty, this ')' has no matching '('.
                    // Mark this ')' for removal.
                    to_keep[i] = false;
                }
            }
            // For lowercase English characters, do nothing; they are always kept.
        }

        // Second pass (after the loop): Any open parentheses remaining in the stack
        // are unmatched and thus invalid. Mark them for removal.
        while (!open_paren_indices.empty()) {
            to_keep[open_paren_indices.top()] = false;
            open_paren_indices.pop();
        }

        // Build the result string by appending only the characters marked to be kept.
        std::string result = "";
        for (int i = 0; i < s.length(); ++i) {
            if (to_keep[i]) {
                result += s[i];
            }
        }

        return result;
    }
};