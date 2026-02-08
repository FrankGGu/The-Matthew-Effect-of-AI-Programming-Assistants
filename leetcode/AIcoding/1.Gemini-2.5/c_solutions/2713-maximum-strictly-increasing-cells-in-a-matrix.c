#include <stdlib.h> // For malloc, free, qsort, calloc

typedef struct {
    int val;
    int r;
    int c;
} CellInfo;

int compareCells(const void *a, const void *b) {
    return ((CellInfo *)a)->val - ((CellInfo *)b)->val;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maxIncreasingCells(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    int n = matrixColSize[0];

    int numCells = m * n;

    // Allocate memory for CellInfo array to store all cells with their coordinates
    CellInfo* cells = (CellInfo*)malloc(numCells * sizeof(CellInfo));
    if (cells == NULL) {
        return 0; // Allocation failed
    }

    // Populate the CellInfo array
    int k = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            cells[k].val = matrix[i][j];
            cells[k].r = i;
            cells[k].c = j;
            k++;
        }
    }

    // Sort cells based on their values
    qsort(cells, numCells, sizeof(CellInfo), compareCells);

    // max_len_row[r] stores the maximum length of a strictly increasing path ending
    // in row 'r' among all cells processed so far (i.e., with smaller values)
    int* max_len_row = (int*)calloc(m, sizeof(int));
    // max_len_col[c] stores the maximum length of a strictly increasing path ending
    // in column 'c' among all cells processed so far (i.e., with smaller values)
    int* max_len_col = (int*)calloc(n, sizeof(int));

    if (max_len_row == NULL || max_len_col == NULL) {
        free(cells);
        free(max_len_row);
        free(max_len_col);
        return 0; // Allocation failed
    }

    // This structure will temporarily store the calculated dp values for cells
    // within the current batch (cells having the same matrix value).
    // This is crucial to prevent cells with the same value from influencing each other's calculations
    // before the entire batch is processed.
    typedef struct {
        int r, c, dp_val;
    } TempUpdate;

    int max_overall_len = 0;

    int i = 0;
    while (i < numCells) {
        int current_val = cells[i].val;
        int j = i;
        // Find all cells that have the same value as current_val
        while (j < numCells && cells[j].val == current_val) {
            j++;
        }
        // Cells from index i to j-1 form the current batch

        // Allocate temporary storage for updates for this batch
        TempUpdate* temp_updates = (TempUpdate*)malloc((j - i) * sizeof(TempUpdate));
        if (temp_updates == NULL) {
            free(cells);
            free(max_len_row);
            free(max_len_col);
            return 0; // Allocation failed
        }
        int update_count = 0;

        // First pass: Calculate dp values for all cells in the current batch
        // using max_len_row and max_len_col values from *previous* batches (smaller values)
        for (int k_batch = i; k_batch < j; k_batch++) {
            int r = cells[k_batch].r;
            int c = cells[k_batch].c;

            // The length of a path ending at (r, c) is 1 plus the maximum length
            // found in its row or column from cells with strictly smaller values.
            int current_cell_dp = 1 + max(max_len_row[r], max_len_col[c]);

            // Store this calculated dp value temporarily
            temp_updates[update_count].r = r;
            temp_updates[update_count].c = c;
            temp_updates[update_count].dp_val = current_cell_dp;
            update_count++;

            // Update the overall maximum length found so far
            max_overall_len = max(max_overall_len, current_cell_dp);
        }

        // Second pass: Apply the calculated dp values from the current batch
        // to max_len_row and max_len_col. This ensures that these arrays
        // are updated only after all cells of the current value have been processed.
        for (int k_update = 0; k_update < update_count; k_update++) {
            int r = temp_updates[k_update].r;
            int c = temp_updates[k_update].c;
            int dp_val = temp_updates[k_update].dp_val;

            max_len_row[r] = max(max_len_row[r], dp_val);
            max_len_col[c] = max(max_len_col[c], dp_val);
        }

        free(temp_updates); // Free temporary storage for this batch

        // Move to the next batch of unique values
        i = j;
    }

    // Free all allocated memory
    free(cells);
    free(max_len_row);
    free(max_len_col);

    return max_overall_len;
}