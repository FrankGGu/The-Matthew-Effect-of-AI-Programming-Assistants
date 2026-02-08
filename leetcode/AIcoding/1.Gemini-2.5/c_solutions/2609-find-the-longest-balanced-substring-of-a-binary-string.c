#include <string.h>

int longestBalancedSubstring(char* s) {
    int max_len = 0;
    int current_zeros = 0;
    int current_ones = 0;
    int n = strlen(s);

    for (int i = 0; i < n; ++i) {
        if (s[i] == '0') {
            if (current_ones > 0) {
                // Transition from '1's to '0's, a potential '0...01...1' segment ended
                // Calculate length for the segment that just finished
                int len = 2 * (current_zeros < current_ones ? current_zeros : current_ones);
                if (len > max_len) {
                    max_len = len;
                }
                current_zeros = 1; // Start a new sequence of zeros
                current_ones = 0;   // Reset ones count
            } else {
                // Continue sequence of zeros
                current_zeros++;
            }
        } else { // s[i] == '1'
            if (current_zeros > 0) {
                // Continue sequence of ones, preceded by zeros
                current_ones++;
            } else {
                // '1's without preceding '0's, cannot form a balanced substring here
                // Reset both counts, effectively ignoring these leading '1's
                current_zeros = 0;
                current_ones = 0;
            }
        }
    }

    // After the loop, check if there's a pending segment
    int len = 2 * (current_zeros < current_ones ? current_zeros : current_ones);
    if (len > max_len) {
        max_len = len;
    }

    return max_len;
}