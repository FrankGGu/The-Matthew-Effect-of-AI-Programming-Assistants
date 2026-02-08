#include <stdlib.h> // For malloc and free

int minSwaps(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int* trailing_zeros = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; ++i) {
        int count = 0;
        for (int j = n - 1; j >= 0; --j) {
            if (grid[i][j] == 0) {
                count++;
            } else {
                break;
            }
        }
        trailing_zeros[i] = count;
    }

    int swaps = 0;
    for (int i = 0; i < n; ++i) {
        int required_zeros = n - 1 - i;
        int found_idx = -1;

        for (int j = i; j < n; ++j) {
            if (trailing_zeros[j] >= required_zeros) {
                found_idx = j;
                break;
            }
        }

        if (found_idx == -1) {
            free(trailing_zeros);
            return -1;
        }

        swaps += (found_idx - i);

        int temp = trailing_zeros[found_idx];
        for (int k = found_idx; k > i; --k) {
            trailing_zeros[k] = trailing_zeros[k-1];
        }
        trailing_zeros[i] = temp;
    }

    free(trailing_zeros);
    return swaps;
}