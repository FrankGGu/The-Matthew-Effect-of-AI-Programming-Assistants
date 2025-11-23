#include <string.h> // For strlen

#define MAX_S_LEN 5000
#define MAX_RUNS_PER_CHAR (MAX_S_LEN / 2 + 1)

int longestSpecialSubstring(char * s){
    int n = strlen(s);

    // run_lengths[char_idx][run_idx] stores the length of a consecutive run of 'char_idx'.
    // run_counts[char_idx] stores the number of runs recorded for that character.
    int run_lengths[26][MAX_RUNS_PER_CHAR];
    int run_counts[26];
    for (int i = 0; i < 26; i++) {
        run_counts[i] = 0;
    }

    int i = 0;
    while (i < n) {
        char current_char = s[i];
        int count = 0;
        int j = i;
        while (j < n && s[j] == current_char) {
            count++;
            j++;
        }
        int char_idx = current_char - 'a';
        run_lengths[char_idx][run_counts[char_idx]] = count;
        run_counts[char_idx]++;
        i = j;
    }

    // Iterate through all possible lengths L, from longest to shortest.
    // If we find an L that satisfies the condition, it's the longest possible.
    for (int L = n; L >= 1; L--) {
        // Check each character 'a' through 'z'.
        for (int char_idx = 0; char_idx < 26; char_idx++) {
            int total_occurrences = 0;
            // Sum occurrences from all runs of the current character.
            for (int k = 0; k < run_counts[char_idx]; k++) {
                int run_len = run_lengths[char_idx][k];
                // A run of length 'run_len' can contribute (run_len - L + 1)
                // substrings of length L, if run_len >= L.
                if (run_len >= L) {
                    total_occurrences += (run_len - L + 1);
                }
            }
            // If the total occurrences for this character and length L is at least 3,
            // then L is the longest special substring length.
            if (total_occurrences >= 3) {
                return L;
            }
        }
    }

    // If no special substring of any length occurs at least thrice, return -1.
    return -1;
}