#include <stdbool.h>
#include <string.h>

bool equalFrequency(char * word) {
    int freq[26] = {0};
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        freq[word[i] - 'a']++;
    }

    // Try removing each character one by one
    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) {
            continue; // This character is not in the word, cannot remove it
        }

        freq[i]--; // Temporarily remove one instance of the current character

        int current_nz_freq = 0; // Stores the first non-zero frequency encountered
        bool possible_after_removal = true; // Flag to check if all remaining frequencies are equal

        // Check if all remaining non-zero frequencies are equal
        for (int j = 0; j < 26; j++) {
            if (freq[j] > 0) { // Only consider characters that are still present
                if (current_nz_freq == 0) {
                    current_nz_freq = freq[j]; // Set the target frequency if this is the first non-zero one
                } else if (freq[j] != current_nz_freq) {
                    // Found a character with a different non-zero frequency, so they are not all equal
                    possible_after_removal = false;
                    break;
                }
            }
        }

        if (possible_after_removal) {
            // If all remaining characters have equal frequency (or there are no characters left),
            // then removing this character worked.
            return true;
        }

        freq[i]++; // Backtrack: Add the character back for the next iteration
    }

    // If no single character removal resulted in equal frequencies, return false
    return false;
}