#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int shortestSequence(int* rolls, int rollsSize, int k) {
    // seen_time[i] stores the segment_id in which number i was last seen.
    // A higher segment_id means it was seen more recently, after a previous target was met.
    // Initialize with 0, meaning no number has been seen yet.
    int* seen_time = (int*)calloc(k + 1, sizeof(int));
    if (seen_time == NULL) {
        // Handle memory allocation failure if necessary, though LeetCode usually guarantees it.
        return -1; // Or some error indicator
    }

    int current_target = 1; // The next number in the sequence [1, 2, 3, ...] we are trying to form.
    int current_segment_id = 1; // Unique identifier for the current "segment" of rolls being processed.

    for (int i = 0; i < rollsSize; i++) {
        int roll = rolls[i];

        // Only consider rolls that are within the valid range [1, k]
        if (roll >= 1 && roll <= k) {
            // Mark the current roll as seen in the current segment
            seen_time[roll] = current_segment_id;

            // If the current target number has been seen in the current segment
            if (seen_time[current_target] == current_segment_id) {
                // We successfully found current_target. Move to the next target.
                current_target++;
                // Start a new segment for the next target.
                // This implicitly "clears" the seen status of numbers from previous segments,
                // as they will have an older segment_id.
                current_segment_id++;

                // If current_target becomes k + 1, it means we have successfully formed
                // the sequence [1, 2, ..., k].
                // The shortest impossible sequence is then [1, 2, ..., k, k+1], which has length k+1.
                if (current_target == k + 1) {
                    free(seen_time);
                    return k + 1;
                }
            }
        }
    }

    // If we reach the end of the rolls array and haven't found a sequence up to k+1,
    // current_target will be the first number we couldn't find in order.
    // For example, if current_target is 3, it means we formed [1, 2], but couldn't find 3 after 2.
    // So, [1, 2, 3] is the shortest impossible sequence, and its length is 3.
    free(seen_time);
    return current_target;
}