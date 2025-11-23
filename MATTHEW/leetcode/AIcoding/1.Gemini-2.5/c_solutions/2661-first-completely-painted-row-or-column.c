#include <stdlib.h>

#define MAX_VAL_MN 100001 // 10^5 + 1

int val_to_pos_map[MAX_VAL_MN][2];
int row_painted_counts[100001];
int col_painted_counts[100001];

int firstCompleteIndex(int* arr, int arrSize, int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0]; // All rows have the same number of columns

    // Initialize counts to zero for each test case.
    // This is important because global/static arrays persist across test cases.
    // We only need to clear up to m-1 and n-1 indices.
    for (int i = 0; i < m; ++i) {
        row_painted_counts[i] = 0;
    }
    for (int i = 0; i < n; ++i) {
        col_painted_counts[i] = 0;
    }

    // Preprocessing: Map each value in mat to its (row, col) position
    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            val_to_pos_map[mat[r][c]][0] = r;
            val_to_pos_map[mat[r][c]][1] = c;
        }
    }

    // Iterate through arr to find the first complete row or column
    for (int k = 0; k < arrSize; ++k) {
        int val = arr[k];
        int r = val_to_pos_map[val][0];
        int c = val_to_pos_map[val][1];

        // Mark cell as painted
        row_painted_counts[r]++;
        col_painted_counts[c]++;

        // Check if row r is complete
        if (row_painted_counts[r] == n) {
            return k;
        }

        // Check if column c is complete
        if (col_painted_counts[c] == m) {
            return k;
        }
    }

    return -1; // Should not be reached based on problem constraints
}