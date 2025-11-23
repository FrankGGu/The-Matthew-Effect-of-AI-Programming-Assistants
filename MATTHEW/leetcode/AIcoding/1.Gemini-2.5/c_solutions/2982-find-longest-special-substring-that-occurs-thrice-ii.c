#include <string.h> // For strlen
#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

static int run_lengths_data[26][200001]; // Max N = 2 * 10^5
static int run_lengths_counts[26];

int longestSpecialSubstring(char * s) {
    int n = strlen(s);

    // Reset counts for each character for the current test case
    for (int i = 0; i < 26; ++i) {
        run_lengths_counts[i] = 0;
    }

    // Phase 1: Identify all maximal consecutive runs of identical characters
    int i = 0;
    while (i < n) {
        char current_char = s[i];
        int count = 0;
        int j = i;
        while (j < n && s[j] == current_char) {
            count++;
            j++;
        }
        // Store this run length for the current character
        int char_idx = current_char - 'a';
        run_lengths_data[char_idx][run_lengths_counts[char_idx]++] = count;
        i = j;
    }

    int max_overall_L = -1;

    // Phase 2: For each character, calculate the maximum possible L
    for (int char_idx = 0; char_idx < 26; ++char_idx) {
        int num_runs = run_lengths_counts[char_idx];
        if (num_runs == 0) {
            continue; // No runs for this character
        }

        // Sort the run lengths for the current character in descending order
        qsort(run_lengths_data[char_idx], num_runs, sizeof(int), compare);

        // r1, r2, r3 are the lengths of the 1st, 2nd, and 3rd longest runs
        int r1 = run_lengths_data[char_idx][0];
        // Use 0 if not enough runs to simplify calculations for cases where r2 or r3 are not available
        int r2 = (num_runs > 1) ? run_lengths_data[char_idx][1] : 0; 
        int r3 = (num_runs > 2) ? run_lengths_data[char_idx][2] : 0;

        // Case 1: All 3 occurrences come from the longest run (r1) itself.
        // We need (r1 - L + 1) >= 3  =>  L <= r1 - 2.
        // The maximum L from this case is r1 - 2.
        if (r1 >= 3) { // A run must be at least 3 long to contain "c" three times
            int candidate_L = r1 - 2;
            if (candidate_L > max_overall_L) {
                max_overall_L = candidate_L;
            }
        }

        // Case 2: Occurrences come from two longest runs (r1 and r2).
        // We need (r1 - L + 1) + (r2 - L + 1) >= 3
        // => r1 + r2 - 2L + 2 >= 3
        // => r1 + r2 - 1 >= 2L
        // => L <= (r1 + r2 - 1) / 2 (integer division implies floor)
        // This case is only possible if there are at least two runs.
        if (num_runs >= 2) {
            int candidate_L = (r1 + r2 - 1) / 2;
            if (candidate_L > max_overall_L) {
                max_overall_L = candidate_L;
            }
        }

        // Case 3: Occurrences come from three or more longest runs (r1, r2, r3, ...).
        // To maximize L, we can choose L = r3.
        // Then r1 contributes (r1 - r3 + 1) >= 1 occurrence.
        // r2 contributes (r2 - r3 + 1) >= 1 occurrence.
        // r3 contributes (r3 - r3 + 1) = 1 occurrence.
        // Total count is at least 3.
        // This case is only possible if there are at least three runs.
        if (num_runs >= 3) {
            int candidate_L = r3;
            if (candidate_L > max_overall_L) {
                max_overall_L = candidate_L;
            }
        }
    }

    // max_overall_L is initialized to -1 and only updated with positive lengths.
    // So, if it's still -1, no valid special substring of length >= 1 was found.
    return max_overall_L;
}