#include <stdlib.h> // For calloc, free

int oddCells(int m, int n, int** indices, int indicesSize, int* indicesColSize) {
    int* row_increments = (int*)calloc(m, sizeof(int));
    int* col_increments = (int*)calloc(n, sizeof(int));

    for (int k = 0; k < indicesSize; k++) {
        int r = indices[k][0];
        int c = indices[k][1];
        row_increments[r]++;
        col_increments[c]++;
    }

    int odd_rows_count = 0;
    for (int i = 0; i < m; i++) {
        if (row_increments[i] % 2 != 0) {
            odd_rows_count++;
        }
    }

    int odd_cols_count = 0;
    for (int j = 0; j < n; j++) {
        if (col_increments[j] % 2 != 0) {
            odd_cols_count++;
        }
    }

    int even_rows_count = m - odd_rows_count;
    int even_cols_count = n - odd_cols_count;

    int total_odd_cells = (odd_rows_count * even_cols_count) + (even_rows_count * odd_cols_count);

    free(row_increments);
    free(col_increments);

    return total_odd_cells;
}