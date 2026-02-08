#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

char** createBoard(int n, int* queens_col_pos) {
    char** board = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        board[i] = (char*)malloc((n + 1) * sizeof(char)); // +1 for null terminator
        for (int j = 0; j < n; j++) {
            board[i][j] = '.';
        }
        board[i][queens_col_pos[i]] = 'Q';
        board[i][n] = '\0';
    }
    return board;
}

void backtrack(int row, int n, int* queens_col_pos, bool* col_taken, bool* diag1_taken, bool* diag2_taken,
               char**** result, int* returnSize, int*** returnColumnSizes, int* currentCapacity) {

    // Base case: All queens have been placed
    if (row == n) {
        // If capacity is reached, double it
        if (*returnSize == *currentCapacity) {
            *currentCapacity *= 2;
            *result = (char***)realloc(*result, (*currentCapacity) * sizeof(char**));
            *returnColumnSizes = (int**)realloc(*returnColumnSizes, (*currentCapacity) * sizeof(int*));
        }

        // Create the board representation
        (*result)[*returnSize] = createBoard(n, queens_col_pos);

        // Prepare returnColumnSizes for the current board
        (*returnColumnSizes)[*returnSize] = (int*)malloc(n * sizeof(int));
        for (int i = 0; i < n; i++) {
            (*returnColumnSizes)[*returnSize][i] = n;
        }

        (*returnSize)++;
        return;
    }

    // Recursive step: Try placing a queen in the current row
    for (int col = 0; col < n; col++) {
        // Check if placing a queen at (row, col) is safe
        // col_taken[col] checks if column is taken
        // diag1_taken[row - col + n - 1] checks main diagonal (row - col is constant)
        // diag2_taken[row + col] checks anti-diagonal (row + col is constant)
        if (!col_taken[col] && !diag1_taken[row - col + n - 1] && !diag2_taken[row + col]) {
            // Place the queen
            queens_col_pos[row] = col;
            col_taken[col] = true;
            diag1_taken[row - col + n - 1] = true;
            diag2_taken[row + col] = true;

            // Recurse for the next row
            backtrack(row + 1, n, queens_col_pos, col_taken, diag1_taken, diag2_taken,
                      result, returnSize, returnColumnSizes, currentCapacity);

            // Backtrack: Remove the queen
            col_taken[col] = false;
            diag1_taken[row - col + n - 1] = false;
            diag2_taken[row + col] = false;
        }
    }
}

char*** solveNQueens(int n, int* returnSize, int** returnColumnSizes) {
    // Initialize result list and its size
    int initialCapacity = 4; // Start with a small capacity, will reallocate
    char*** result = (char***)malloc(initialCapacity * sizeof(char**));
    *returnColumnColumnSizes = (int**)malloc(initialCapacity * sizeof(int*)); // Corrected type
    *returnSize = 0;

    // Data structures for backtracking
    int* queens_col_pos = (int*)malloc(n * sizeof(int)); // stores column index for queen in each row
    bool* col_taken = (bool*)calloc(n, sizeof(bool)); // columns taken
    bool* diag1_taken = (bool*)calloc(2 * n - 1, sizeof(bool)); // main diagonals (row - col + offset)
    bool* diag2_taken = (bool*)calloc(2 * n - 1, sizeof(bool)); // anti-diagonals (row + col)

    // Start backtracking from the first row
    backtrack(0, n, queens_col_pos, col_taken, diag1_taken, diag2_taken,
              &result, returnSize, returnColumnColumnSizes, &initialCapacity); // Corrected type

    // Free temporary memory used by backtracking
    free(queens_col_pos);
    free(col_taken);
    free(diag1_taken);
    free(diag2_taken);

    // Reallocate result and returnColumnSizes to exact size
    *result = (char***)realloc(result, (*returnSize) * sizeof(char**));
    *returnColumnColumnSizes = (int**)realloc(*returnColumnColumnSizes, (*returnSize) * sizeof(int*)); // Corrected type

    return result;
}