#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int* movesToStamp(char* stamp, char* target, int* returnSize) {
    int m = strlen(stamp);
    int n = strlen(target);

    // mutable_target will store the current state of the target string,
    // where stamped characters are replaced by '?'.
    char* mutable_target = (char*)malloc(sizeof(char) * (n + 1));
    strcpy(mutable_target, target);

    // ans stores indices in reverse order of discovery, will be reversed at the end.
    // Max n stamps can be applied.
    int* ans = (int*)malloc(sizeof(int) * n);
    int ans_idx = 0;

    // Queue for indices of windows that are ready to be stamped.
    // Max (n-m+1) possible windows.
    int* q = (int*)malloc(sizeof(int) * (n - m + 1));
    int q_front = 0;
    int q_rear = 0;

    // State for each window target[i...i+m-1]:
    // mismatches[i]: count of characters in target[i...i+m-1] that are NOT '?'
    //                AND do NOT match the corresponding character in stamp.
    int* mismatches = (int*)calloc(n - m + 1, sizeof(int));
    // non_q_count[i]: count of characters in target[i...i+m-1] that are NOT '?'.
    int* non_q_count = (int*)calloc(n - m + 1, sizeof(int));
    // in_queue[i]: boolean to track if window i is already in the queue to avoid duplicates.
    bool* in_queue = (bool*)calloc(n - m + 1, sizeof(bool));

    // Initialize state for all possible windows and populate the initial queue.
    for (int i = 0; i <= n - m; i++) {
        for (int k = 0; k < m; k++) {
            if (mutable_target[i + k] != stamp[k]) {
                mismatches[i]++;
            }
            if (mutable_target[i + k] != '?') {
                non_q_count[i]++;
            }
        }
        // A window is ready to be stamped if it has no mismatches
        // and still contains at least one non-'?' character.
        if (mismatches[i] == 0 && non_q_count[i] > 0) {
            q[q_rear++] = i;
            in_queue[i] = true;
        }
    }

    int q_total_chars = 0; // Total number of '?' characters in mutable_target.

    // Process windows from the queue.
    while (q_front < q_rear) {
        int curr_idx = q[q_front++];
        ans[ans_idx++] = curr_idx;

        // "Stamp" the current window by changing its characters to '?'.
        // This process also updates states of overlapping windows.
        for (int k = 0; k < m; k++) {
            // Only process if the character is not already '?'.
            if (mutable_target[curr_idx + k] != '?') {
                // Store the original character to correctly update mismatches for overlapping windows.
                char original_char_at_k = mutable_target[curr_idx + k];
                mutable_target[curr_idx + k] = '?'; // Mark as stamped.
                q_total_chars++; // Increment total '?' count.

                // This character change affects all windows 'j' that cover 'curr_idx + k'.
                // 'j' ranges from `max(0, curr_idx + k - m + 1)` to `min(n - m, curr_idx + k)`.
                int start_j = MAX(0, curr_idx + k - m + 1);
                int end_j = MIN(n - m, curr_idx + k);

                for (int j = start_j; j <= end_j; j++) {
                    // Update state for window 'j'.
                    // The character at `mutable_target[curr_idx + k]` (original_char_at_k)
                    // was at relative position `(curr_idx + k - j)` within window 'j'.

                    non_q_count[j]--; // This character is now '?', so decrement non_q_count.

                    // If the original character was a mismatch for window 'j',
                    // then this mismatch is now resolved as it became '?'.
                    if (original_char_at_k != stamp[curr_idx + k - j]) {
                        mismatches[j]--;
                    }

                    // If window 'j' now has no mismatches and still has non-'?' characters,
                    // and it's not already in the queue, add it to the queue.
                    if (mismatches[j] == 0 && non_q_count[j] > 0 && !in_queue[j]) {
                        q[q_rear++] = j;
                        in_queue[j] = true;
                    }
                }
            }
        }
    }

    // After processing all possible stamps, check if the entire target is '?'s.
    if (q_total_chars != n) {
        // If not, it's impossible to stamp the sequence.
        free(mutable_target);
        free(ans);
        free(q);
        free(mismatches);
        free(non_q_count);
        free(in_queue);
        *returnSize = 0;
        return NULL;
    }

    // Reverse the ans array to get the correct stamping order.
    for (int i = 0; i < ans_idx / 2; i++) {
        int temp = ans[i];
        ans[i] = ans[ans_idx - 1 - i];
        ans[ans_idx - 1 - i] = temp;
    }

    // Free all dynamically allocated memory.
    free(mutable_target);
    free(q);
    free(mismatches);
    free(non_q_count);
    free(in_queue);
    *returnSize = ans_idx;
    return ans;
}