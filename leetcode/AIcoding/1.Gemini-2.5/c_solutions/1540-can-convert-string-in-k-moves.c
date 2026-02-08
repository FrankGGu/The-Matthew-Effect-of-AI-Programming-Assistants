#include <string.h>
#include <stdbool.h>

bool canConvertString(char * s, char * t, int k) {
    int n = strlen(s);

    // Array to store the count of times each shift value (1-25) has been used.
    // Index 0 is unused, indices 1-25 correspond to shifts.
    // The maximum value an element in shift_counts can reach is 'n' (10^5),
    // which fits comfortably within an 'int'.
    int shift_counts[26] = {0}; 

    for (int i = 0; i < n; i++) {
        if (s[i] == t[i]) {
            continue; // No shift is needed for this character.
        }

        // Calculate the required shift value.
        // This will be a number from 1 to 25.
        // Example: 'a' to 'c' -> diff = 2.
        // Example: 'c' to 'a' -> diff = (0 - 2 + 26) % 26 = 24.
        int diff = (t[i] - s[i] + 26) % 26; 

        // Calculate the actual move number that would be used for this shift.
        // If 'diff' is 1, and it's the first time we need a shift of 1, the move number is 1.
        // If 'diff' is 1, and it's the second time, the move number is 1 + 1*26 = 27.
        // If 'diff' is 1, and it's the (C+1)-th time, the move number is 1 + C*26.
        // The maximum possible value for current_move_number would be
        // 25 (max diff) + (n-1) * 26 (max shift_counts for n=10^5).
        // 25 + (10^5 - 1) * 26 = 25 + 2599974 = 2599999.
        // This value fits within a standard 'int' (which typically goes up to 2*10^9).
        int current_move_number = diff + shift_counts[diff] * 26;

        if (current_move_number > k) {
            return false; // If the required move number exceeds 'k', it's impossible.
        }

        shift_counts[diff]++; // Increment the count for this specific shift value.
    }

    return true; // If the loop completes, all characters can be converted within 'k' moves.
}