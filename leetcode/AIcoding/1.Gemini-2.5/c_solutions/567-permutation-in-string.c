#include <stdbool.h>
#include <string.h>

bool checkInclusion(char * s1, char * s2){
    int s1_len = strlen(s1);
    int s2_len = strlen(s2);

    if (s1_len > s2_len) {
        return false;
    }

    int s1_freq[26] = {0};
    int window_freq[26] = {0};
    int matches = 0; // Number of characters with matching frequencies

    // Populate s1_freq and initial window_freq for the first window
    for (int i = 0; i < s1_len; i++) {
        s1_freq[s1[i] - 'a']++;
        window_freq[s2[i] - 'a']++;
    }

    // Calculate initial matches for the first window
    for (int i = 0; i < 26; i++) {
        if (s1_freq[i] == window_freq[i]) {
            matches++;
        }
    }

    // If the first window is a permutation, return true
    if (matches == 26) {
        return true;
    }

    // Slide the window
    for (int i = s1_len; i < s2_len; i++) {
        int char_to_add_idx = s2[i] - 'a';
        int char_to_remove_idx = s2[i - s1_len] - 'a';

        // Update matches for the character leaving the window
        // If frequencies were equal before removing, decrement matches
        if (s1_freq[char_to_remove_idx] == window_freq[char_to_remove_idx]) {
            matches--;
        }
        window_freq[char_to_remove_idx]--;
        // If frequencies become equal after removing, increment matches
        if (s1_freq[char_to_remove_idx] == window_freq[char_to_remove_idx]) {
            matches++;
        }

        // Update matches for the character entering the window
        // If frequencies were equal before adding, decrement matches
        if (s1_freq[char_to_add_idx] == window_freq[char_to_add_idx]) {
            matches--;
        }
        window_freq[char_to_add_idx]++;
        // If frequencies become equal after adding, increment matches
        if (s1_freq[char_to_add_idx] == window_freq[char_to_add_idx]) {
            matches++;
        }

        // If all 26 character counts match, we found a permutation
        if (matches == 26) {
            return true;
        }
    }

    return false;
}