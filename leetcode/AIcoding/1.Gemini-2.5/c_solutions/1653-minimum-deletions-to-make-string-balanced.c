#include <string.h>
#include <stdlib.h> // For NULL and size_t, though not strictly needed for this specific problem context

int minimumDeletions(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    // total_a_count: counts 'a's in the suffix (right part of the split)
    // b_count_left: counts 'b's in the prefix (left part of the split)
    int total_a_count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            total_a_count++;
        }
    }

    int b_count_left = 0;
    // Initialize min_deletions for the case where the split is before the first character (k=0).
    // This means the entire string should be 'b's. Deletions = 0 'b's from left + total_a_count 'a's from right.
    int min_deletions = total_a_count;

    // Iterate through all possible split points.
    // The loop variable 'i' represents the current character s[i] that is being moved
    // from the right part of the split to the left part.
    // After processing s[i], b_count_left and total_a_count reflect the state for the split
    // point *after* s[i].
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            // If s[i] is 'a', it moves from the right part to the left part.
            // It no longer contributes to 'a's needing deletion from the right part.
            total_a_count--;
        } else { // s[i] == 'b'
            // If s[i] is 'b', it moves from the right part to the left part.
            // It now contributes to 'b's needing deletion from the left part.
            b_count_left++;
        }

        // Calculate deletions for the current split point:
        // (b's in the left part that need to be deleted) + (a's in the right part that need to be deleted)
        int current_deletions = b_count_left + total_a_count;
        if (current_deletions < min_deletions) {
            min_deletions = current_deletions;
        }
    }

    return min_deletions;
}