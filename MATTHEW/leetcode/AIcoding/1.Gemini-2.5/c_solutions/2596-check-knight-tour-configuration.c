#include <stdbool.h>

bool checkKnightTourConfiguration(int** grid, int gridRowSize, int* gridColSize) {
    int n = gridRowSize;

    if (grid[0][0] != 0) {
        return false;
    }

    int pos[n * n][2];
    for (int r = 0; r < n; r++) {
        for (int c = 0; c < n; c++) {
            pos[grid[r][c]][0] = r;
            pos[grid[r][c]][1] = c;
        }
    }

    int dr[] = {-2, -2, -1, -1, 1, 1, 2, 2};
    int dc[] = {-1, 1, -2, 2, -2, 2, -1, 1};

    for (int k = 0; k < n * n - 1; k++) {
        int r_k = pos[k][0];
        int c_k = pos[k][1];

        int r_next = pos[k + 1][0];
        int c_next = pos[k + 1][1];

        bool isValidMove = false;
        for (int i = 0; i < 8; i++) {
            int temp_r = r_k + dr[i];
            int temp_c = c_k + dc[i];

            if (temp_r == r_next && temp_c == c_next) {
                isValidMove = true;
                break;
            }
        }

        if (!isValidMove) {
            return false;
        }
    }

    return true;
}