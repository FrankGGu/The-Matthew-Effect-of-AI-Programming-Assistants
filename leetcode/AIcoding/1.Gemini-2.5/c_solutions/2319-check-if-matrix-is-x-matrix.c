#include <stdbool.h>

bool checkXMatrix(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;

    for (int r = 0; r < n; r++) {
        for (int c = 0; c < n; c++) {
            bool on_diagonal = (r == c) || (r + c == n - 1);

            if (on_diagonal) {
                if (grid[r][c] == 0) {
                    return false;
                }
            } else {
                if (grid[r][c] != 0) {
                    return false;
                }
            }
        }
    }

    return true;
}