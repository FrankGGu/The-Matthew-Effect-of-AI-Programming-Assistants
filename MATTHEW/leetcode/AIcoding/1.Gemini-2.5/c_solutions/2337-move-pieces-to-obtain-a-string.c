#include <stdbool.h>
#include <string.h>

bool canChange(char* start, char* target) {
    int n = strlen(start);
    int i = 0; // Pointer for start string
    int j = 0; // Pointer for target string

    while (i < n && j < n) {
        // Skip '_' characters in start
        while (i < n && start[i] == '_') {
            i++;
        }
        // Skip '_' characters in target
        while (j < n && target[j] == '_') {
            j++;
        }

        // If one string ran out of non-'_' characters while the other didn't
        // This implies a mismatch in the sequence of 'L'/'R' characters
        if (i == n || j == n) {
            break; 
        }

        // If characters at current non-'_' positions don't match
        // This also implies a mismatch in the sequence of 'L'/'R' characters
        if (start[i] != target[j]) {
            return false;
        }

        // Apply movement constraints based on the character type
        if (start[i] == 'L') {
            // 'L' can only move left, so its initial position 'i' must be greater than or equal to its final position 'j'.
            // If 'i' < 'j', it means 'L' moved right, which is not allowed.
            if (i < j) {
                return false;
            }
        } else { // start[i] == 'R'
            // 'R' can only move right, so its initial position 'i' must be less than or equal to its final position 'j'.
            // If 'i' > 'j', it means 'R' moved left, which is not allowed.
            if (i > j) {
                return false;
            }
        }

        // Move to the next non-'_' character in both strings
        i++;
        j++;
    }

    // After the loop, ensure both pointers have reached the end of their respective strings
    // (i.e., all non-'_' characters have been processed and matched correctly).
    // This handles cases where one string might have trailing '_'s or non-'_'s unmatched.
    while (i < n && start[i] == '_') {
        i++;
    }
    while (j < n && target[j] == '_') {
        j++;
    }

    return i == n && j == n;
}