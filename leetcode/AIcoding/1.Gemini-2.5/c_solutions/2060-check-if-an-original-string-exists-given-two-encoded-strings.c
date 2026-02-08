#include <stdbool.h>
#include <string.h>
#include <ctype.h> // For isdigit

int memo[41][41][81];

bool solve(char* s1, char* s2, int i, int j, int diff, int s1_len, int s2_len) {
    // Base case: Both strings are fully processed
    if (i == s1_len && j == s2_len) {
        return diff == 0; // True if all differences in length have been resolved
    }

    // Check memoization table
    if (memo[i][j][diff + 40] != -1) {
        return memo[i][j][diff + 40];
    }

    bool res = false;

    // Option 1: s1 processes a number
    // If s1[i] is a digit, it represents skipping 'num' characters.
    // This increases s1's effective length, so 'diff' increases by 'num'.
    if (i < s1_len && isdigit(s1[i])) {
        int num = 0;
        for (int k = 0; k < 3 && i + k < s1_len && isdigit(s1[i + k]); k++) {
            num = num * 10 + (s1[i + k] - '0');
            // Recursively call with s1 advanced by k+1, and diff increased by num
            if (solve(s1, s2, i + k + 1, j, diff + num, s1_len, s2_len)) {
                res = true;
                break; // Found a valid path, no need to try other number lengths for s1[i]
            }
        }
    }

    // Option 2: s2 processes a number
    // If s2[j] is a digit, it represents skipping 'num' characters.
    // This increases s2's effective length, so 'diff' decreases by 'num'.
    if (j < s2_len && isdigit(s2[j])) {
        int num = 0;
        for (int k = 0; k < 3 && j + k < s2_len && isdigit(s2[j + k]); k++) {
            num = num * 10 + (s2[j + k] - '0');
            // Recursively call with s2 advanced by k+1, and diff decreased by num
            if (solve(s1, s2, i, j + k + 1, diff - num, s1_len, s2_len)) {
                res = true;
                break; // Found a valid path, no need to try other number lengths for s2[j]
            }
        }
    }

    // Option 3: Process characters (non-digits)
    // This part handles matching characters or consuming pending skips.

    // If diff is 0, both strings are aligned. Try to match characters.
    if (diff == 0 && i < s1_len && j < s2_len && !isdigit(s1[i]) && !isdigit(s2[j])) {
        if (s1[i] == s2[j]) {
            // If characters match, advance both pointers, diff remains 0.
            res = res || solve(s1, s2, i + 1, j + 1, 0, s1_len, s2_len);
        }
    }
    // If diff < 0, it means s2 has effectively skipped more characters than s1.
    // s1 needs to "catch up" by consuming a character.
    // Consuming a character from s1 reduces its deficit, so diff increases by 1.
    else if (diff < 0 && i < s1_len && !isdigit(s1[i])) {
        res = res || solve(s1, s2, i + 1, j, diff + 1, s1_len, s2_len);
    }
    // If diff > 0, it means s1 has effectively skipped more characters than s2.
    // s2 needs to "catch up" by consuming a character.
    // Consuming a character from s2 reduces its deficit, so diff decreases by 1.
    else if (diff > 0 && j < s2_len && !isdigit(s2[j])) {
        res = res || solve(s1, s2, i, j + 1, diff - 1, s1_len, s2_len);
    }

    // Store and return the result
    return memo[i][j][diff + 40] = res;
}

bool possiblyEquals(char * s1, char * s2){
    int s1_len = strlen(s1);
    int s2_len = strlen(s2);

    // Initialize memoization table with -1 (indicating uncomputed states)
    for (int i = 0; i <= s1_len; i++) {
        for (int j = 0; j <= s2_len; j++) {
            for (int k = 0; k <= 80; k++) {
                memo[i][j][k] = -1;
            }
        }
    }

    // Start the recursive process from the beginning of both strings with a diff of 0
    return solve(s1, s2, 0, 0, 0, s1_len, s2_len);
}