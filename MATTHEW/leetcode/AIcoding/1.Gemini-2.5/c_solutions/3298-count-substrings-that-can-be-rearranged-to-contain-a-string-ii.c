#include <string.h>
#include <stdlib.h>

long long countSubstrings(char* s, char* target) {
    int n = strlen(s);
    int m = strlen(target);

    int target_freq[26] = {0};
    for (int i = 0; i < m; i++) {
        target_freq[target[i] - 'a']++;
    }

    int required_chars_count = 0;
    for (int i = 0; i < 26; i++) {
        if (target_freq[i] > 0) {
            required_chars_count++;
        }
    }

    long long total_count = 0;
    int current_freq[26] = {0};
    int current_chars_met = 0;
    int right = 0; // Exclusive end of the current window s[left...right-1]

    for (int left = 0; left < n; left++) {
        // Expand the right pointer until the window s[left...right-1] is valid
        // or until right reaches the end of s.
        while (right < n && current_chars_met < required_chars_count) {
            int char_added_idx = s[right] - 'a';

            // Increment frequency for char_added
            if (target_freq[char_added_idx] > 0 && current_freq[char_added_idx] < target_freq[char_added_idx]) {
                current_freq[char_added_idx]++;
                if (current_freq[char_added_idx] == target_freq[char_added_idx]) {
                    current_chars_met++;
                }
            } else {
                current_freq[char_added_idx]++;
            }
            right++;
        }

        // If a valid window s[left...right-1] is found
        if (current_chars_met == required_chars_count) {
            // All substrings starting at 'left' and ending from 'right-1' to 'n-1' are valid.
            // The count of such substrings is n - (right-1).
            total_count += (n - (right - 1));
        } else {
            // If current_chars_met < required_chars_count, it means 'right' reached 'n'
            // but no valid window starting at 'left' could be formed.
            // Since adding characters only helps, no further 'left' will form a valid window either.
            break;
        }

        // Remove s[left] from the window for the next iteration (left+1)
        int char_removed_idx = s[left] - 'a';
        if (target_freq[char_removed_idx] > 0 && current_freq[char_removed_idx] == target_freq[char_removed_idx]) {
            current_chars_met--;
        }
        current_freq[char_removed_idx]--;
    }

    return total_count;
}