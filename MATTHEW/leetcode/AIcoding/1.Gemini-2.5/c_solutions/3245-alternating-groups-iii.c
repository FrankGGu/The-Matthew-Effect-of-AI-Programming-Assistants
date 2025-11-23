#include <stdlib.h> // For malloc and free

int numberOfAlternatingGroups(int* colors, int colorsSize, int k) {
    // Handle the special case where k is 1.
    // Any single element forms an alternating group of length 1.
    if (k == 1) {
        return colorsSize;
    }

    // Step 1: Create the 'diff' array.
    // diff[i] = 1 if colors[i] != colors[(i+1)%colorsSize], else 0.
    // This array indicates if the pair (colors[i], colors[(i+1)%colorsSize]) is alternating.
    // A group of k elements is alternating if k-1 consecutive pairs are alternating.
    int* diff = (int*)malloc(colorsSize * sizeof(int));
    // If malloc fails, return 0 (though LeetCode typically guarantees successful allocation for typical constraints).
    if (diff == NULL) {
        return 0;
    }

    for (int i = 0; i < colorsSize; i++) {
        diff[i] = (colors[i] != colors[(i + 1) % colorsSize]) ? 1 : 0;
    }

    // Step 2: Handle the case where k-1 (the required length of consecutive 1s in diff)
    // is greater than or equal to colorsSize.
    // If k-1 >= colorsSize, it means the alternating condition must hold for all n pairs in the circular array.
    // Thus, all elements in the 'diff' array must be 1.
    // If all are 1, then any starting position forms a valid group (n groups). Otherwise, 0 groups.
    if (k - 1 >= colorsSize) {
        int all_ones = 1;
        for (int i = 0; i < colorsSize; i++) {
            if (diff[i] == 0) {
                all_ones = 0;
                break;
            }
        }
        free(diff); // Free the allocated memory for diff
        return all_ones ? colorsSize : 0;
    }

    // Step 3: Use a sliding window for the case where k-1 < colorsSize.
    // We need to find windows of length k-1 in the 'diff' array (circularly) that sum to k-1.
    // To handle circularity, we extend the 'diff' array by appending its first k-1 elements.
    int extended_diff_size = colorsSize + (k - 1);
    int* extended_diff = (int*)malloc(extended_diff_size * sizeof(int));
    if (extended_diff == NULL) {
        free(diff); // Free diff if extended_diff fails
        return 0;
    }

    // Copy original diff elements
    for (int i = 0; i < colorsSize; i++) {
        extended_diff[i] = diff[i];
    }
    // Append first k-1 elements to handle circular wrap-around for windows
    for (int i = 0; i < k - 1; i++) {
        extended_diff[colorsSize + i] = diff[i];
    }
    free(diff); // The original diff array is no longer needed

    int ans = 0;
    int current_ones = 0;

    // Initialize the sum for the first window of length k-1
    // This window corresponds to the group starting at colors[0]
    for (int i = 0; i < k - 1; i++) {
        current_ones += extended_diff[i];
    }

    // Check if the first window is all ones
    if (current_ones == k - 1) {
        ans++;
    }

    // Slide the window across the extended_diff array
    // Each iteration corresponds to a new starting position for a group in the original 'colors' array
    for (int i = 1; i < colorsSize; i++) {
        // Remove the element leaving the window
        current_ones -= extended_diff[i - 1];
        // Add the new element entering the window
        current_ones += extended_diff[i + k - 2];

        // If the current window sum is k-1, it means all elements in this window are 1
        if (current_ones == k - 1) {
            ans++;
        }
    }

    free(extended_diff); // Free the allocated memory for extended_diff
    return ans;
}