#include <stdlib.h> // For malloc, calloc, free
#include <string.h> // For strcpy
#include <stdbool.h> // For bool type

static char* result_seq;
static int seq_len;
static int N_val; // Renamed 'N' to 'N_val' to avoid potential conflict with macro 'N' if any
static bool* used_nums; // Tracks if a number (1 to N_val) has been placed
static char* current_seq; // The sequence being built

static bool backtrack(int idx) {
    // Base case: If we have filled all positions
    if (idx == seq_len) {
        // Found a valid sequence, copy it to result_seq
        strcpy(result_seq, current_seq);
        return true; // Indicate that a solution was found
    }

    // If the current position is already filled (by a previous placement of num+gap+num)
    if (current_seq[idx] != 0) {
        return backtrack(idx + 1);
    }

    // Try placing numbers from 1 to N_val
    // We iterate from 1 to N_val to find the lexicographically smallest sequence
    for (int num = 1; num <= N_val; num++) {
        if (!used_nums[num]) { // If 'num' has not been placed yet
            if (num == 1) {
                // Number 1 appears once
                current_seq[idx] = (char)('0' + num);
                used_nums[num] = true;

                if (backtrack(idx + 1)) {
                    return true; // Propagate solution up
                }

                // Backtrack: undo the placement
                used_nums[num] = false;
                current_seq[idx] = 0; // Reset to empty
            } else {
                // Numbers > 1 appear twice with a gap of num-1
                int second_idx = idx + num;
                // Check if the second position is within bounds and is empty
                if (second_idx < seq_len && current_seq[second_idx] == 0) {
                    current_seq[idx] = (char)('0' + num);
                    current_seq[second_idx] = (char)('0' + num);
                    used_nums[num] = true;

                    if (backtrack(idx + 1)) {
                        return true; // Propagate solution up
                    }

                    // Backtrack: undo the placement
                    used_nums[num] = false;
                    current_seq[idx] = 0; // Reset to empty
                    current_seq[second_idx] = 0; // Reset to empty
                }
            }
        }
    }
    return false; // No solution found from this path
}

char* findLexicographicallySmallestValidSequence(int n) {
    N_val = n;
    seq_len = 2 * n - 1;

    // Allocate memory for the result string (plus null terminator)
    result_seq = (char*)malloc(sizeof(char) * (seq_len + 1));
    // Allocate and initialize current_seq with 0s (representing empty slots)
    current_seq = (char*)calloc(seq_len + 1, sizeof(char)); 
    // Allocate and initialize used_nums with false
    used_nums = (bool*)calloc(n + 1, sizeof(bool)); 

    // Start backtracking from the first position (index 0)
    // The problem guarantees a solution exists, so backtrack(0) will always return true.
    backtrack(0);

    // Null-terminate the result string
    result_seq[seq_len] = '\0'; 

    // Free temporary memory used during backtracking
    free(current_seq);
    free(used_nums);

    // Return the dynamically allocated result string.
    // The caller is responsible for freeing result_seq.
    return result_seq;
}