#include <string.h>
#include <stdlib.h> // For abs, min

int char_to_idx(char c) {
    if (c == 'Q') return 0;
    if (c == 'W') return 1;
    if (c == 'E') return 2;
    if (c == 'R') return 3;
    return -1; // Should not happen with problem constraints
}

int is_balanced_enough(int* counts, int k) {
    return counts[0] <= k && counts[1] <= k && counts[2] <= k && counts[3] <= k;
}

int balancedString(char* s) {
    int n = strlen(s);
    int k = n / 4;

    int counts[4] = {0}; // Counts for 'Q', 'W', 'E', 'R'

    // Initial pass: count all characters in the string
    for (int i = 0; i < n; i++) {
        counts[char_to_idx(s[i])]++;
    }

    // If the string is already balanced, no replacement needed
    if (is_balanced_enough(counts, k)) {
        return 0;
    }

    int left = 0;
    int min_len = n;

    // Sliding window: right pointer expands
    for (int right = 0; right < n; right++) {
        // Character at s[right] is now considered part of the window.
        // So, its count is decremented from the 'outside' string's perspective.
        counts[char_to_idx(s[right])]--;

        // Try to shrink the window from the left while the 'outside' string is balanced enough
        while (is_balanced_enough(counts, k) && left <= right) {
            // Current window [left, right] is a valid candidate for replacement
            int current_len = right - left + 1;
            if (current_len < min_len) {
                min_len = current_len;
            }

            // Shrink window from left: s[left] is now considered 'outside' the window again.
            // Its count is incremented.
            counts[char_to_idx(s[left])]++;
            left++;
        }
    }

    return min_len;
}