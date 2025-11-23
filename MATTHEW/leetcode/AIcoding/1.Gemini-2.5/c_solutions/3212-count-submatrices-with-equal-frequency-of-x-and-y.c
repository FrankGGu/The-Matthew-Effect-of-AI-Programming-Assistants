#include <stdlib.h> // For malloc, calloc, free
#include "uthash.h" // For hash map

typedef struct {
    int size;
    int* tree;
} FenwickTree;

FenwickTree* createFenwickTree(int size) {
    FenwickTree* ft = (FenwickTree*)malloc(sizeof(FenwickTree));
    ft->size = size;
    ft->tree = (int*)calloc(size + 1, sizeof(int)); // 1-indexed, size+1 elements
    return ft;
}

void updateFenwickTree(FenwickTree* ft, int idx, int delta) {
    idx++; // Convert to 1-indexed
    while (idx <= ft->size) {
        ft->tree[idx] += delta;
        idx += idx & (-idx);
    }
}

int queryFenwickTree(FenwickTree* ft, int idx) {
    idx++; // Convert to 1-indexed
    int sum = 0;
    while (idx > 0) {
        sum += ft->tree[idx];
        idx -= idx & (-idx);
    }
    return sum;
}

void freeFenwickTree(FenwickTree* ft) {
    free(ft->tree);
    free(ft);
}

typedef struct {
    int key; // prefix_sum_A (offsetted to be non-negative)
    FenwickTree* ft;
    UT_hash_handle hh;
} FtMapEntry;

FtMapEntry* find_entry(FtMapEntry** head, int key) {
    FtMapEntry* entry;
    HASH_FIND_INT(*head, &key, entry);
    return entry;
}

FtMapEntry* add_get_entry(FtMapEntry** head, int key, int max_sum_x) {
    FtMapEntry* entry = find_entry(head, key);
    if (entry == NULL) {
        entry = (FtMapEntry*)malloc(sizeof(FtMapEntry));
        entry->key = key;
        entry->ft = createFenwickTree(max_sum_x + 1);
        HASH_ADD_INT(*head, key, entry);
    }
    return entry;
}

int countSubmatrices(char** grid, int gridSize, int* gridColSize) {
    int N = gridSize;
    int M = gridColSize[0];

    int total_count = 0;

    // Maximum possible sum of 'X's in a submatrix
    // Used for Fenwick tree size
    const int MAX_VAL_SUM_X = N * M; 
    // Offset for prefix_sum_A to make keys non-negative for hash map
    const int OFFSET_DIFF = N * M;

    // Precompute column-wise prefix sums for diff (X-Y) and count_X
    // col_prefix_diff[k][j] stores sum of (X-Y) for grid[0...k-1][j]
    // col_prefix_x[k][j] stores sum of X for grid[0...k-1][j]
    int** col_prefix_diff = (int**)malloc((N + 1) * sizeof(int*));
    int** col_prefix_x = (int**)malloc((N + 1) * sizeof(int*));
    for (int i = 0; i <= N; i++) {
        col_prefix_diff[i] = (int*)calloc(M, sizeof(int));
        col_prefix_x[i] = (int*)calloc(M, sizeof(int));
    }

    for (int j = 0; j < M; j++) {
        for (int i = 0; i < N; i++) {
            int val_diff = 0;
            int val_x = 0;
            if (grid[i][j] == 'X') {
                val_diff = 1;
                val_x = 1;
            } else if (grid[i][j] == 'Y') {
                val_diff = -1;
            }
            col_prefix_diff[i+1][j] = col_prefix_diff[i][j] + val_diff;
            col_prefix_x[i+1][j] = col_prefix_x[i][j] + val_x;
        }
    }

    // Iterate over all possible top rows (r1)
    for (int r1 = 0; r1 < N; r1++) {
        // Iterate over all possible bottom rows (r2)
        for (int r2 = r1; r2 < N; r2++) {
            // A[j] = sum of (X-Y) in column j from r1 to r2
            // B[j] = sum of X in column j from r1 to r2
            int* A = (int*)malloc(M * sizeof(int));
            int* B = (int*)malloc(M * sizeof(int));
            for (int j = 0; j < M; j++) {
                A[j] = col_prefix_diff[r2+1][j] - col_prefix_diff[r1][j];
                B[j] = col_prefix_x[r2+1][j] - col_prefix_x[r1][j];
            }

            // prefix_sum_A[k] = sum of A[0...k-1]
            // prefix_sum_B[k] = sum of B[0...k-1]
            int* prefix_sum_A = (int*)calloc(M + 1, sizeof(int));
            int* prefix_sum_B = (int*)calloc(M + 1, sizeof(int));
            for (int k = 0; k < M; k++) {
                prefix_sum_A[k+1] = prefix_sum_A[k] + A[k];
                prefix_sum_B[k+1] = prefix_sum_B[k] + B[k];
            }

            // Hash map to store Fenwick Trees.
            // Key: prefix_sum_A (offsetted)
            // Value: FenwickTree storing frequencies of prefix_sum_B values
            FtMapEntry* ft_map_head = NULL;

            // Initialize for the empty prefix (before c=0), which means prefix_sum_A=0, prefix_sum_B=0
            FtMapEntry* entry_for_zero = add_get_entry(&ft_map_head, 0 + OFFSET_DIFF, MAX_VAL_SUM_X);
            updateFenwickTree(entry_for_zero->ft, 0, 1);

            // Iterate over possible right columns (c2) from 0 to M-1
            // In terms of prefix sums, this means iterating from k=1 to M
            for (int c_idx = 1; c_idx <= M; c_idx++) {
                int current_prefix_A = prefix_sum_A[c_idx];
                int current_prefix_B = prefix_sum_B[c_idx];

                // Offset current_prefix_A for hash map key
                int current_prefix_A_offset = current_prefix_A + OFFSET_DIFF;

                // Find entries where prefix_sum_A is the same as current_prefix_A
                FtMapEntry* current_entry = find_entry(&ft_map_head, current_prefix_A_offset);
                if (current_entry != NULL) {
                    // Query Fenwick tree for count of prev_B values less than current_prefix_B
                    // This means (current_prefix_B - prev_B) > 0
                    total_count += queryFenwickTree(current_entry->ft, current_prefix_B - 1);
                }

                // Add current (prefix_sum_A, prefix_sum_B) pair to the map
                FtMapEntry* add_entry = add_get_entry(&ft_map_head, current_prefix_A_offset, MAX_VAL_SUM_X);
                updateFenwickTree(add_entry->ft, current_prefix_B, 1);
            }

            // Clean up Fenwick Trees and hash map for this (r1, r2) pair
            FtMapEntry *current_entry_cleanup, *tmp_entry_cleanup;
            HASH_ITER(hh, ft_map_head, current_entry_cleanup, tmp_entry_cleanup) {
                freeFenwickTree(current_entry_cleanup->ft);
                HASH_DEL(ft_map_head, current_entry_cleanup);
                free(current_entry_cleanup);
            }

            free(A);
            free(B);
            free(prefix_sum_A);
            free(prefix_sum_B);
        }
    }

    // Free precomputed column prefix sum arrays
    for (int i = 0; i <= N; i++) {
        free(col_prefix_diff[i]);
        free(col_prefix_x[i]);
    }
    free(col_prefix_diff);
    free(col_prefix_x);

    return total_count;
}