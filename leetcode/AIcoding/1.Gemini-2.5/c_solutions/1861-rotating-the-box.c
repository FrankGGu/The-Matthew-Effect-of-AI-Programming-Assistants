#include <stdlib.h> // Required for malloc

char** rotateTheBox(char** box, int boxSize, int* boxColSize, int* returnSize, int** returnColumnSizes) {
    int original_rows = boxSize;
    int original_cols = boxColSize[0];

    // The new box will have dimensions: original_cols x original_rows
    int new_rows = original_cols;
    int new_cols = original_rows;

    // Allocate memory for the returnSize and returnColumnSizes
    *returnSize = new_rows;
    *returnColumnSizes = (int*)malloc(sizeof(int) * new_rows);
    for (int i = 0; i < new_rows; i++) {
        (*returnColumnSizes)[i] = new_cols;
    }

    // Allocate memory for the result matrix
    char** result = (char**)malloc(sizeof(char*) * new_rows);
    for (int i = 0; i < new_rows; i++) {
        result[i] = (char*)malloc(sizeof(char) * new_cols);
    }

    // Iterate through each column of the *new* result matrix
    // 'new_col_idx' corresponds to 'c_new' in the rotation (c_new = original_rows - 1 - r_orig)
    // 'new_col_idx' also corresponds to 'k' in the problem description's final matrix columns
    for (int new_col_idx = 0; new_col_idx < new_cols; new_col_idx++) {
        int stones_count = 0;
        // 'empty_slot_row' tracks the lowest available row index in the current column of the result matrix
        // Stones fall towards increasing row indices in the new matrix
        int empty_slot_row = new_rows - 1;

        // The elements that form result[...][new_col_idx] originate from a specific row in the original box.
        // The original row index is (original_rows - 1 - new_col_idx).
        int original_row_to_process = original_rows - 1 - new_col_idx;

        // Iterate through the elements of this original row from right to left.
        // 'original_col_idx' corresponds to 'c_orig' in the original box.
        // In the new matrix, 'original_col_idx' becomes the 'new_row_idx'.
        for (int original_col_idx = original_cols - 1; original_col_idx >= 0; original_col_idx--) {
            char cell = box[original_row_to_process][original_col_idx];

            if (cell == '#') {
                stones_count++;
            } else if (cell == '*') {
                // An obstacle is encountered. Place all accumulated stones above it.
                while (stones_count > 0) {
                    result[empty_slot_row][new_col_idx] = '#';
                    empty_slot_row--;
                    stones_count--;
                }
                // Place the obstacle itself
                result[empty_slot_row][new_col_idx] = '*';
                empty_slot_row--;
                // Reset stones_count as the obstacle blocks further falling
                stones_count = 0;
            }
            // If cell is '.', it's an empty space, which will either be filled by falling stones
            // or remain empty (filled with '.' later). Do nothing for now.
        }

        // After processing all elements in the original row, place any remaining accumulated stones
        while (stones_count > 0) {
            result[empty_slot_row][new_col_idx] = '#';
            empty_slot_row--;
            stones_count--;
        }

        // Fill any remaining empty slots at the top of the current column with '.'
        while (empty_slot_row >= 0) {
            result[empty_slot_row][new_col_idx] = '.';
            empty_slot_row--;
        }
    }

    return result;
}