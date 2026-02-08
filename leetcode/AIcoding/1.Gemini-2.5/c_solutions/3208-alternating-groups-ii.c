#include <stdlib.h> // Required for malloc and free

int numberOfAlternatingGroups(int* colors, int colorsSize, int k) {
    if (k == 1) {
        return colorsSize;
    }

    // Create an extended array to handle circularity.
    // We need colors[0]...colors[colorsSize-1], then colors[0]...colors[k-2]
    // Total length will be colorsSize + k - 1.
    int extended_len = colorsSize + k - 1;
    int* extended_colors = (int*)malloc(extended_len * sizeof(int));
    if (extended_colors == NULL) {
        // Handle memory allocation failure if necessary, though LeetCode usually assumes success.
        return 0; 
    }
    for (int i = 0; i < extended_len; ++i) {
        extended_colors[i] = colors[i % colorsSize];
    }

    // Create a 'diff' array: diff[i] = 1 if extended_colors[i] != extended_colors[i+1], else 0.
    // This array indicates if a pair of adjacent elements is alternating.
    // The length of this array will be (extended_len - 1) = (colorsSize + k - 2).
    int diff_len = extended_len - 1;
    int* diff = (int*)malloc(diff_len * sizeof(int));
    if (diff == NULL) {
        free(extended_colors); // Clean up previously allocated memory
        return 0;
    }
    for (int i = 0; i < diff_len; ++i) {
        diff[i] = (extended_colors[i] != extended_colors[i+1]);
    }

    // Use a sliding window on the 'diff' array.
    // An alternating group of size 'k' requires 'k-1' alternating pairs.
    // This means the sum of 'k-1' consecutive elements in 'diff' must be 'k-1'.
    int current_alternating_pairs = 0;
    for (int i = 0; i < k - 1; ++i) {
        current_alternating_pairs += diff[i];
    }

    int count = 0;
    // Check the first window (starting at index 0)
    if (current_alternating_pairs == k - 1) {
        count++;
    }

    // Slide the window for the remaining starting positions.
    // There are 'colorsSize' possible starting positions (0 to colorsSize-1).
    // We already checked for starting position 0.
    // Now check for starting positions 1 to colorsSize-1.
    for (int i = 1; i < colorsSize; ++i) {
        // Remove the contribution of the pair that leaves the window from the left
        current_alternating_pairs -= diff[i - 1];
        // Add the contribution of the new pair that enters the window from the right
        // The new rightmost pair for a window starting at 'i' is (extended_colors[i+k-2], extended_colors[i+k-1]),
        // which corresponds to diff[i+k-2].
        current_alternating_pairs += diff[i + k - 2];

        if (current_alternating_pairs == k - 1) {
            count++;
        }
    }

    free(extended_colors);
    free(diff);

    return count;
}