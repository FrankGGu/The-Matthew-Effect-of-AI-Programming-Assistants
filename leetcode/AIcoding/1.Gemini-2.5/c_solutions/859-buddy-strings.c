#include <stdbool.h>
#include <string.h>

bool buddyStrings(char * s, char * goal) {
    int n1 = strlen(s);
    int n2 = strlen(goal);

    if (n1 != n2) {
        return false;
    }

    // Case 1: s and goal are identical
    if (strcmp(s, goal) == 0) {
        // If s and goal are the same, we need to be able to swap two characters in s
        // to get s back. This is only possible if s contains at least one duplicate character.
        int freq[26] = {0};
        for (int i = 0; i < n1; i++) {
            freq[s[i] - 'a']++;
            if (freq[s[i] - 'a'] > 1) {
                return true; // Found a duplicate character, can swap them
            }
        }
        return false; // No duplicate characters, cannot swap to make it equal
    }

    // Case 2: s and goal are different
    // Find differing positions
    int diff_indices[2];
    int diff_count = 0;

    for (int i = 0; i < n1; i++) {
        if (s[i] != goal[i]) {
            if (diff_count >= 2) {
                // More than two differences, cannot be buddy strings with a single swap
                return false;
            }
            diff_indices[diff_count] = i;
            diff_count++;
        }
    }

    // Check the number of differences
    if (diff_count == 2) {
        // Exactly two differences. Check if swapping s[idx1] and s[idx2] makes them equal.
        // This requires s[idx1] to be equal to goal[idx2] AND s[idx2] to be equal to goal[idx1].
        if (s[diff_indices[0]] == goal[diff_indices[1]] &&
            s[diff_indices[1]] == goal[diff_indices[0]]) {
            return true;
        } else {
            return false;
        }
    } else {
        // If diff_count is 0, it means s and goal were identical, which is handled above.
        // If diff_count is 1, we cannot make them equal with a single swap.
        // If diff_count is > 2, it would have returned false earlier.
        return false;
    }
}