#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MAX

int get_swaps(int* arr, int n) {
    int mismatch_0 = 0; // Mismatches if target is 0, 1, 0, 1...
    int mismatch_1 = 0; // Mismatches if target is 1, 0, 1, 0...
    int count_zeros = 0;

    for (int k = 0; k < n; k++) {
        if (arr[k] == 0) {
            count_zeros++;
        }
        if (arr[k] != k % 2) { // Compare with 0, 1, 0, 1...
            mismatch_0++;
        }
        if (arr[k] != (k + 1) % 2) { // Compare with 1, 0, 1, 0...
            mismatch_1++;
        }
    }

    // Check if the number of zeros/ones is valid
    if (n % 2 == 0) { // Even n: must have n/2 zeros and n/2 ones
        if (count_zeros != n / 2) {
            return INT_MAX; // Impossible
        }
        // For even n, we can achieve either 0101... or 1010...
        // The number of swaps is half the number of misplaced elements.
        // mismatch_0 is the count of elements that need to change to match 0101...
        // mismatch_1 is the count of elements that need to change to match 1010...
        // We choose the pattern that requires fewer swaps.
        // Both mismatch_0 and mismatch_1 must be even for a valid swap count.
        // It's guaranteed for even n and count_zeros == n/2.
        return (mismatch_0 < mismatch_1 ? mismatch_0 : mismatch_1) / 2;
    } else { // Odd n: must have (n/2) zeros and (n/2 + 1) ones, or vice versa
        if (count_zeros == n / 2 + 1) { // Target pattern must start with 0 (e.g., 010 for n=3)
            if (mismatch_0 % 2 != 0) return INT_MAX; // Should be even for valid swaps
            return mismatch_0 / 2;
        } else if (count_zeros == n / 2) { // Target pattern must start with 1 (e.g., 101 for n=3)
            if (mismatch_1 % 2 != 0) return INT_MAX; // Should be even for valid swaps
            return mismatch_1 / 2;
        } else {
            return INT_MAX; // Impossible
        }
    }
}

int movesToChessboard(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;

    // Allocate memory for the first row and first column arrays
    int* row_arr = (int*)malloc(n * sizeof(int));
    int* col_arr = (int*)malloc(n * sizeof(int));

    // Populate row_arr with elements from the first column of the board
    // Populate col_arr with elements from the first row of the board
    for (int i = 0; i < n; i++) {
        row_arr[i] = board[i][0];
        col_arr[i] = board[0][i];
    }

    // Step 1: Validate board consistency
    // A valid chessboard transformation implies that for any 2x2 subgrid,
    // the elements must satisfy board[i][j] ^ board[i][0] ^ board[0][j] ^ board[0][0] == 0.
    // This ensures that every row is either identical to the first row or its complement,
    // and similarly for columns.
    for (int i = 1; i < n; i++) {
        for (int j = 1; j < n; j++) {
            if ((board[i][j] ^ board[i][0] ^ board[0][j] ^ board[0][0]) != 0) {
                free(row_arr);
                free(col_arr);
                return -1;
            }
        }
    }

    // Step 2: Calculate minimum swaps for rows
    int row_swaps = get_swaps(row_arr, n);
    if (row_swaps == INT_MAX) {
        free(row_arr);
        free(col_arr);
        return -1;
    }

    // Step 3: Calculate minimum swaps for columns
    int col_swaps = get_swaps(col_arr, n);
    if (col_swaps == INT_MAX) {
        free(row_arr);
        free(col_arr);
        return -1;
    }

    free(row_arr);
    free(col_arr);

    return row_swaps + col_swaps;
}