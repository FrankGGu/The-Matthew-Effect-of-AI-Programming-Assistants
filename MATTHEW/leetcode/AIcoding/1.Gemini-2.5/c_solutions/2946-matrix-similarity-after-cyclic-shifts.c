#include <stdbool.h>

bool areSimilar(int** mat, int matSize, int* matColSize, int k) {
    int m = matSize;
    int n = matColSize[0];

    int k_effective = k % n;

    if (k_effective == 0) {
        return true;
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (i % 2 == 0) { // Even row: right shift
                int original_val = mat[i][j];
                int source_idx = (j - k_effective + n) % n;
                if (original_val != mat[i][source_idx]) {
                    return false;
                }
            } else { // Odd row: left shift
                int original_val = mat[i][j];
                int source_idx = (j + k_effective) % n;
                if (original_val != mat[i][source_idx]) {
                    return false;
                }
            }
        }
    }

    return true;
}