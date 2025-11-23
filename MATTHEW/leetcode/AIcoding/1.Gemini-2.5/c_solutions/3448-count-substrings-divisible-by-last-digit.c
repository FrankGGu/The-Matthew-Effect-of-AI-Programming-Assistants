#include <string.h>

int countDivisibleSubstrings(char* num) {
    int n = strlen(num);
    int count = 0;

    // Iterate over all possible starting positions 'i'
    for (int i = 0; i < n; i++) {
        // current_mod_values[d] will store (value of substring num[i...j]) % d
        // for d from 1 to 9.
        // The array is indexed 0-9, but we only use indices 1-9 as divisors.
        int current_mod_values[10]; 
        for (int d = 1; d <= 9; d++) {
            current_mod_values[d] = 0; // Initialize for an empty prefix before num[i]
        }

        // Iterate over all possible ending positions 'j' for the current 'i'
        for (int j = i; j < n; j++) {
            int digit_val = num[j] - '0';
            int last_digit = digit_val; // The last digit of the current substring num[i...j]

            // Update all current_mod_values for the substring num[i...j]
            // This effectively calculates (value of num[i...j]) % d for all d from 1 to 9.
            for (int d = 1; d <= 9; d++) {
                current_mod_values[d] = (current_mod_values[d] * 10 + digit_val) % d;
            }

            // Check if the current substring num[i...j] is divisible by its last digit.
            // According to typical problem constraints for "Count Substrings Divisible By Last Digit",
            // the input string 'num' consists of digits '1'-'9'.
            // Therefore, 'last_digit' will always be non-zero, so no explicit check for last_digit == 0 is needed.
            if (current_mod_values[last_digit] == 0) {
                count++;
            }
        }
    }

    return count;
}