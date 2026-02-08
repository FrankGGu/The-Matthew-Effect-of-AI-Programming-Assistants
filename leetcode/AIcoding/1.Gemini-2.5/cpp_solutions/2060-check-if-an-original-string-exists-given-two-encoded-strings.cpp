#include <string>
#include <vector>
#include <numeric>
#include <cctype>

class Solution {
public:
    std::string s1_str, s2_str;
    // memo[i][j][diff + OFFSET] stores the result for state (i, j, diff)
    // i: current index in s1_str
    // j: current index in s2_str
    // diff: s1_str's effective length matched so far minus s2_str's effective length matched so far
    // Max diff can be 999 (e.g., s1="999", s2="a"), min diff can be -999 (e.g., s1="a", s2="999")
    // So diff ranges from -999 to 999. OFFSET is used to map this range to non-negative array indices.
    int memo[41][41][2001]; 
    const int OFFSET = 1000;

    bool solve(int i, int j, int diff) {
        // Base Case: Both strings exhausted
        if (i == s1_str.length() && j == s2_str.length()) {
            return diff == 0;
        }

        // Memoization check
        if (memo[i][j][diff + OFFSET] != -1) {
            return memo[i][j][diff + OFFSET];
        }

        bool possible = false;

        // Option 1: s1_str processes its current element
        if (i < s1_str.length()) {
            if (isdigit(s1_str[i])) { // s1_str[i] is a digit
                int num = 0;
                // Try parsing 1, 2, or 3 digits to form a number
                for (int k = i; k < s1_str.length() && k < i + 3; ++k) {
                    num = num * 10 + (s1_str[k] - '0');
                    // s1_str skips `num` characters. This adds `num` to s1_str's effective length.
                    // So `diff` increases by `num`.
                    if (solve(k + 1, j, diff + num)) {
                        possible = true;
                        break; // Found a path, no need to try other numbers from s1_str[i]
                    }
                }
            } else { // s1_str[i] is a character
                if (diff > 0) { // s1_str has matched more. s1_str[i] is one of those `diff` characters.
                    // s1_str consumes s1_str[i]. `diff` decreases by 1.
                    if (solve(i + 1, j, diff - 1)) {
                        possible = true;
                    }
                } else if (diff == 0) { // Aligned, s2_str must also be a char and match
                    if (j < s2_str.length() && !isdigit(s2_str[j]) && s1_str[i] == s2_str[j]) {
                        // Both consume a matching character. `diff` remains 0.
                        if (solve(i + 1, j + 1, 0)) {
                            possible = true;
                        }
                    }
                } else { // diff < 0, s2_str has matched more. s1_str[i] is a new character for s1_str.
                    // s1_str consumes s1_str[i]. `diff` increases by 1.
                    if (solve(i + 1, j, diff + 1)) {
                        possible = true;
                    }
                }
            }
        }

        // Option 2: s2_str processes its current element (only if s1_str processing didn't yield a solution)
        if (!possible && j < s2_str.length()) {
            if (isdigit(s2_str[j])) { // s2_str[j] is a digit
                int num = 0;
                // Try parsing 1, 2, or 3 digits to form a number
                for (int k = j; k < s2_str.length() && k < j + 3; ++k) {
                    num = num * 10 + (s2_str[k] - '0');
                    // s2_str skips `num` characters. This adds `num` to s2_str's effective length.
                    // So `diff` decreases by `num`.
                    if (solve(i, k + 1, diff - num)) {
                        possible = true;
                        break; // Found a path, no need to try other numbers from s2_str[j]
                    }
                }
            } else { // s2_str[j] is a character
                if (diff < 0) { // s2_str has matched more. s2_str[j] is one of those `abs(diff)` characters.
                    // s2_str consumes s2_str[j]. `diff` increases by 1.
                    if (solve(i, j + 1, diff + 1)) {
                        possible = true;
                    }
                } else if (diff == 0) { 
                    // If diff == 0, and we are here, it means s1_str[i] was either exhausted, a digit,
                    // or a character that didn't match s2_str[j].
                    // In any of these cases, s2_str[j] cannot be consumed if diff == 0.
                    // So, this branch correctly does not lead to a solution.
                } else { // diff > 0, s1_str has matched more. s2_str[j] is a new character for s2_str.
                    // s2_str consumes s2_str[j]. `diff` decreases by 1.
                    if (solve(i, j + 1, diff - 1)) {
                        possible = true;
                    }
                }
            }
        }

        return memo[i][j][diff + OFFSET] = possible;
    }

    bool possiblyEquals(std::string s1, std::string s2) {
        s1_str = s1;
        s2_str = s2;

        // Initialize memoization table with -1 (uncomputed)
        for (int i = 0; i <= s1.length(); ++i) {
            for (int j = 0; j <= s2.length(); ++j) {
                for (int k = 0; k <= 2000; ++k) { // diff + OFFSET ranges from 0 to 1999
                    memo[i][j][k] = -1;
                }
            }
        }

        return solve(0, 0, 0);
    }
};