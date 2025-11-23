#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::string largestPalindromic(std::string num) {
        std::vector<int> counts(10, 0);
        for (char c : num) {
            counts[c - '0']++;
        }

        std::string left_half = "";

        // Build the left half of the palindrome.
        // Prioritize larger digits.
        // Non-zero digits first to avoid leading zeros.
        for (int d = 9; d >= 1; --d) {
            for (int i = 0; i < counts[d] / 2; ++i) {
                left_half += (char)(d + '0');
            }
            counts[d] %= 2; // Update remaining count for middle digit consideration
        }

        // Add '0's to the left half, but only if left_half is not empty.
        // This ensures '0's are not leading digits (e.g., "010" is not allowed, "1" is preferred).
        if (!left_half.empty()) {
            for (int i = 0; i < counts[0] / 2; ++i) {
                left_half += '0';
            }
        }
        counts[0] %= 2; // Update remaining count for '0' for middle digit consideration

        // Find the largest single digit for the middle of the palindrome.
        char middle_digit = '\0';
        for (int d = 9; d >= 0; --d) {
            if (counts[d] == 1) {
                middle_digit = (char)(d + '0');
                break;
            }
        }

        // Construct the full palindrome string.
        std::string result = left_half;
        if (middle_digit != '\0') {
            result += middle_digit;
        }
        std::string right_half = left_half;
        std::reverse(right_half.begin(), right_half.end());
        result += right_half;

        // Handle edge cases:
        // 1. If result is empty, it means no palindromic number could be formed
        //    (e.g., input was empty, or only single non-zero digits like "13").
        //    However, if the input contained '0's, "0" is a valid palindrome.
        if (result.empty()) {
            // Check if the original input num contained any '0's.
            // If it did, and no other palindrome could be formed, "0" is the answer.
            bool has_zero = false;
            for (char c : num) {
                if (c == '0') {
                    has_zero = true;
                    break;
                }
            }
            if (has_zero) {
                return "0";
            } else {
                return "";
            }
        }

        return result;
    }
};