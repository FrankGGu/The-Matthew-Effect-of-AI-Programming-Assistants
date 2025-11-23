#include <string.h>
#include <stdlib.h>

int pos_data[26][100002];
int pos_counts[26];

long long countUniqueChars(char * s){
    int n = strlen(s);
    long long total_sum = 0;

    // Initialize pos_counts and add a sentinel -1 for each character.
    // This -1 represents an occurrence before the string starts.
    for (int i = 0; i < 26; ++i) {
        pos_counts[i] = 0;
        pos_data[i][pos_counts[i]++] = -1;
    }

    // Populate pos_data with actual indices of each character in the string.
    for (int i = 0; i < n; ++i) {
        int char_idx = s[i] - 'A';
        pos_data[char_idx][pos_counts[char_idx]++] = i;
    }

    // Add a sentinel 'n' for each character.
    // This 'n' represents an occurrence after the string ends.
    for (int i = 0; i < 26; ++i) {
        pos_data[i][pos_counts[i]++] = n;
    }

    // Calculate the contribution of each character occurrence to the total sum.
    // For each occurrence of a character s[k] at index k, its contribution
    // is (k - prev_idx) * (next_idx - k), where prev_idx is the index of
    // the previous occurrence of the same character, and next_idx is the
    // index of the next occurrence of the same character.
    for (int i = 0; i < 26; ++i) {
        // Iterate through the actual occurrences (skipping the sentinels at pos_data[i][0] and pos_data[i][pos_counts[i]-1]).
        for (int j = 1; j < pos_counts[i] - 1; ++j) {
            long long current_idx = pos_data[i][j];
            long long prev_idx = pos_data[i][j-1];
            long long next_idx = pos_data[i][j+1];

            // The number of substrings where s[current_idx] is unique is
            // (number of possible start positions) * (number of possible end positions).
            // Start positions: from prev_idx + 1 to current_idx. Count: current_idx - prev_idx.
            // End positions: from current_idx to next_idx - 1. Count: next_idx - current_idx.
            total_sum += (current_idx - prev_idx) * (next_idx - current_idx);
        }
    }

    return total_sum;
}