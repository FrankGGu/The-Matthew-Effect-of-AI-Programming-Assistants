#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string removeKdigits(std::string num, int k) {
        std::string result_stack; // Use string as a stack

        for (char digit : num) {
            // While stack is not empty, k > 0, and current digit is smaller than top of stack
            while (!result_stack.empty() && k > 0 && result_stack.back() > digit) {
                result_stack.pop_back();
                k--;
            }
            // Avoid pushing leading zeros if the stack is currently empty
            // (unless it's the only digit, which will be handled by the final "0" return)
            if (result_stack.empty() && digit == '0') {
                continue;
            }
            result_stack.push_back(digit);
        }

        // If k is still greater than 0, remove remaining digits from the end
        // This handles cases like "12345" where digits are in increasing order
        while (k > 0 && !result_stack.empty()) {
            result_stack.pop_back();
            k--;
        }

        // If the result_stack is empty after removals, it means all digits were removed
        if (result_stack.empty()) {
            return "0";
        }

        // The previous logic for `if (result_stack.empty() && digit == '0') continue;`
        // should have handled most leading zeros.
        // However, if the number was "100" and k=1, result_stack might become "00"
        // after processing. So, we still need to trim leading zeros.
        size_t first_digit_idx = 0;
        while (first_digit_idx < result_stack.length() && result_stack[first_digit_idx] == '0') {
            first_digit_idx++;
        }

        // If all digits were removed or all remaining are zeros
        if (first_digit_idx == result_stack.length()) {
            return "0";
        }

        // Return the substring from the first non-zero digit
        return result_stack.substr(first_digit_idx);
    }
};