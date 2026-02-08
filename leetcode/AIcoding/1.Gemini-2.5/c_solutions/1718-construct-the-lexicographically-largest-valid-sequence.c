#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool solve(int index, int n, int* sequence, bool* used) {
    int len = 2 * n - 1;

    // Base case: If we have successfully filled all positions in the sequence
    if (index == len) {
        return true;
    }

    // If the current position is already filled (by a previous placement of a number 'k' at 'index - k'),
    // move to the next position.
    if (sequence[index] != 0) {
        return solve(index + 1, n, sequence, used);
    }

    // Iterate through numbers from n down to 1 to construct the lexicographically largest sequence.
    for (int num = n; num >= 1; num--) {
        // If the current number 'num' has not been used yet
        if (!used[num]) {
            if (num == 1) {
                // Number 1 appears only once.
                sequence[index] = 1;
                used[1] = true; // Mark 1 as used

                // Recurse for the next position
                if (solve(index + 1, n, sequence, used)) {
                    return true; // Found a valid sequence
                }

                // Backtrack: unmark 1 and clear the position
                used[1] = false;
                sequence[index] = 0;

            } else {
                // Number num > 1 appears twice, with num - 1 elements between its two occurrences.
                // The second occurrence would be at index + num.
                int second_pos = index + num;

                // Check if the second position is within bounds and is currently empty
                if (second_pos < len && sequence[second_pos] == 0) {
                    sequence[index] = num;
                    sequence[second_pos] = num;
                    used[num] = true; // Mark num as used

                    // Recurse for the next position
                    if (solve(index + 1, n, sequence, used)) {
                        return true; // Found a valid sequence
                    }

                    // Backtrack: unmark num and clear both positions
                    used[num] = false;
                    sequence[second_pos] = 0;
                    sequence[index] = 0;
                }
            }
        }
    }

    // If no number can be placed at the current index to form a valid sequence, backtrack
    return false;
}

int* constructDistancedSequence(int n, int* returnSize) {
    int len = 2 * n - 1;
    int* sequence = (int*)malloc(sizeof(int) * len);
    // used[0] is unused, used[1] to used[n] track if a number has been placed
    bool* used = (bool*)malloc(sizeof(bool) * (n + 1)); 

    // Initialize sequence array with 0s (indicating empty slots)
    memset(sequence, 0, sizeof(int) * len);
    // Initialize used array with false (indicating no numbers have been placed yet)
    memset(used, false, sizeof(bool) * (n + 1));

    // Start the backtracking process from the first position (index 0)
    solve(0, n, sequence, used);

    // Set the return size for the caller
    *returnSize = len;

    // Free the temporary used array
    free(used);

    // Return the constructed sequence
    return sequence;
}