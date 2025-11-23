#include <string>
#include <algorithm> // Required for std::max

class Solution {
public:
    bool checkValidString(std::string s) {
        int min_open = 0; // Minimum possible count of unmatched open parentheses
        int max_open = 0; // Maximum possible count of unmatched open parentheses

        for (char c : s) {
            if (c == '(') {
                min_open++;
                max_open++;
            } else if (c == ')') {
                min_open--;
                max_open--;
            } else { // c == '*'
                min_open--; // Treat '*' as ')' to minimize open count
                max_open++; // Treat '*' as '(' to maximize open count
            }

            // If max_open becomes negative, it means we have too many ')'
            // that cannot be balanced even if all '*' are treated as '('.
            // In this case, the string is invalid.
            if (max_open < 0) {
                return false;
            }

            // min_open cannot be negative. If it is, it means we encountered
            // a ')' that couldn't be matched by a preceding '(' or a '*' acting as '('.
            // However, a '*' can also act as an empty string, effectively
            // "absorbing" an unmatched ')' without needing a preceding '('.
            // So, we reset min_open to 0 if it drops below zero.
            min_open = std::max(0, min_open);
        }

        // After iterating through the entire string, if min_open is 0,
        // it means it's possible to balance the string. Any remaining 'max_open'
        // can be treated as empty strings.
        return min_open == 0;
    }
};