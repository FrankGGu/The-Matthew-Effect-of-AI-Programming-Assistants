#include <stdlib.h> // For calloc and free

int findLatestStep(int* arr, int arrSize, int m) {
    int n = arrSize;
    if (n == 0) {
        return -1;
    }

    // lengths[i] stores the length of the group starting at i,
    // and also the length of the group ending at i.
    // We use n+2 size for 1-based indexing and boundary sentinels (0 and n+1).
    // Indices 0 and n+1 will always have length 0, acting as virtual boundaries.
    int* lengths = (int*)calloc(n + 2, sizeof(int));
    // counts[k] stores the number of groups of length k.
    // Max possible length is n.
    int* counts = (int*)calloc(n + 1, sizeof(int));

    int ans = -1;

    for (int i = 0; i < n; ++i) {
        int pos = arr[i]; // Current position to set to 1

        // Get lengths of adjacent groups
        // lengths[pos - 1] gives the length of the group ending at pos-1
        int left_len = lengths[pos - 1];
        // lengths[pos + 1] gives the length of the group starting at pos+1
        int right_len = lengths[pos + 1];

        // If adjacent groups existed, decrement their counts
        if (left_len > 0) {
            counts[left_len]--;
        }
        if (right_len > 0) {
            counts[right_len]--;
        }

        // Calculate new combined length
        // The new group consists of left_len + current bit (1) + right_len
        int new_len = 1 + left_len + right_len;

        // Update lengths at the new group's boundaries
        // The new group starts at (pos - left_len)
        lengths[pos - left_len] = new_len;
        // The new group ends at (pos + right_len)
        lengths[pos + right_len] = new_len;
        // Note: lengths[pos] itself does not need to be updated as it's not a boundary.

        // Increment count for the new length
        counts[new_len]++;

        // If there is at least one group of size m, update the answer
        if (counts[m] > 0) {
            ans = i + 1; // i+1 because steps are 1-indexed
        }
    }

    // Free allocated memory
    free(lengths);
    free(counts);

    return ans;
}