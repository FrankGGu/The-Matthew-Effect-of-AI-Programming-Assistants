#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

int minDeletionSize(char **strs, int strsSize, int* strsColSize) {
    if (strsSize == 0) {
        return 0;
    }

    int n = strsSize; // Number of rows
    int m = strsColSize[0]; // Number of columns (all strings have same length)

    if (m == 0) {
        return 0;
    }

    // is_sorted_between_rows[k] is true if strs[k] is already lexicographically less than strs[k+1]
    // considering only the columns kept so far.
    // If true, we don't need to check this pair for future columns.
    bool* is_sorted_between_rows = (bool*) malloc((n - 1) * sizeof(bool));
    if (is_sorted_between_rows == NULL) {
        return 0; // Handle allocation error
    }

    for (int i = 0; i < n - 1; ++i) {
        is_sorted_between_rows[i] = false;
    }

    int kept_columns_count = 0;

    for (int col_idx = 0; col_idx < m; ++col_idx) {
        bool should_delete_this_column = false;
        for (int k = 0; k < n - 1; ++k) {
            if (!is_sorted_between_rows[k]) { // Only check if this pair is not yet sorted
                if (strs[k][col_idx] > strs[k+1][col_idx]) {
                    should_delete_this_column = true;
                    break; // This column violates sorting for this pair, so it must be deleted
                }
            }
        }

        if (!should_delete_this_column) {
            // This column can be kept.
            kept_columns_count++;
            // Update the sorted status for pairs that are now strictly sorted
            for (int k = 0; k < n - 1; ++k) {
                if (!is_sorted_between_rows[k]) {
                    if (strs[k][col_idx] < strs[k+1][col_idx]) {
                        is_sorted_between_rows[k] = true;
                    }
                }
            }
        }
    }

    free(is_sorted_between_rows);

    return kept_columns_count;
}