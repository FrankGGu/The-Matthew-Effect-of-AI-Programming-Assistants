#include <stdlib.h> // For malloc, realloc, free, abs
#include <string.h> // For strlen, strncmp
#include <stdbool.h> // For bool type

int* findBeautifulIndices(char* s, char* a, char* b, int k, int* returnSize) {
    int s_len = strlen(s);
    int a_len = strlen(a);
    int b_len = strlen(b);

    // Store indices where 'a' is found
    // Max possible occurrences is s_len (e.g., s="aaaaa", a="a")
    int* a_indices = (int*)malloc(s_len * sizeof(int));
    int a_count = 0;

    // Find all occurrences of 'a'
    // Loop runs only if 'a' can fit in 's'
    for (int i = 0; i <= s_len - a_len; ++i) {
        if (strncmp(s + i, a, a_len) == 0) {
            a_indices[a_count++] = i;
        }
    }

    // Store indices where 'b' is found
    int* b_indices = (int*)malloc(s_len * sizeof(int));
    int b_count = 0;

    // Find all occurrences of 'b'
    // Loop runs only if 'b' can fit in 's'
    for (int i = 0; i <= s_len - b_len; ++i) {
        if (strncmp(s + i, b, b_len) == 0) {
            b_indices[b_count++] = i;
        }
    }

    // Store the result indices
    // Max possible result indices is a_count (which is at most s_len)
    int* result = (int*)malloc(a_count * sizeof(int));
    int result_count = 0;

    // Iterate through each index where 'a' was found
    for (int i_idx = 0; i_idx < a_count; ++i_idx) {
        int current_i = a_indices[i_idx];
        bool found_j_for_current_i = false;

        // For each 'current_i', check if there's any 'j' satisfying the condition
        for (int j_idx = 0; j_idx < b_count; ++j_idx) {
            int current_j = b_indices[j_idx];
            if (abs(current_i - current_j) <= k) {
                found_j_for_current_i = true;
                break; // Found a valid j for this i, no need to check other j's
            }
        }

        // If a valid 'j' was found for 'current_i', add 'current_i' to the result.
        // Since 'a_indices' is sorted and contains unique indices,
        // and we iterate through it in order, the 'result' array will naturally
        // be sorted and contain unique 'i' values.
        if (found_j_for_current_i) {
            result[result_count++] = current_i;
        }
    }

    // Free temporary allocations
    free(a_indices);
    free(b_indices);

    // Set the return size and reallocate the result array to its exact size
    *returnSize = result_count;
    if (result_count == 0) {
        free(result); // Free the initially allocated memory for result
        return NULL;
    }
    return (int*)realloc(result, result_count * sizeof(int));
}