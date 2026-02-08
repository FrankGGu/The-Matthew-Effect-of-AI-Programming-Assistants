#include <stdbool.h>

bool canStamp(int gridRow, int gridCol, int stampRow, int stampCol, int row, int col, char** grid, char** stamp) {
    for (int i = 0; i < stampRow; i++) {
        for (int j = 0; j < stampCol; j++) {
            if (grid[row + i][col + j] == 'X' && stamp[i][j] == 'X') {
                return false;
            }
        }
    }
    return true;
}

void applyStamp(int gridRow, int gridCol, int stampRow, int stampCol, int row, int col, char** grid, char** stamp) {
    for (int i = 0; i < stampRow; i++) {
        for (int j = 0; j < stampCol; j++) {
            if (stamp[i][j] == 'X') {
                grid[row + i][col + j] = 'X';
            }
        }
    }
}

bool canStampGrid(int gridRow, int gridCol, int stampRow, int stampCol, char** grid, char** stamp) {
    for (int i = 0; i <= gridRow - stampRow; i++) {
        for (int j = 0; j <= gridCol - stampCol; j++) {
            if (canStamp(gridRow, gridCol, stampRow, stampCol, i, j, grid, stamp)) {
                applyStamp(gridRow, gridCol, stampRow, stampCol, i, j, grid, stamp);
                return true;
            }
        }
    }
    return false;
}

bool canStampAll(int gridRow, int gridCol, int stampRow, int stampCol, char** grid, char** stamp) {
    while (true) {
        if (!canStampGrid(gridRow, gridCol, stampRow, stampCol, grid, stamp)) {
            break;
        }
    }
    for (int i = 0; i < gridRow; i++) {
        for (int j = 0; j < gridCol; j++) {
            if (grid[i][j] == 'O') {
                return false;
            }
        }
    }
    return true;
}

bool canStamp(char** grid, int gridRowSize, int gridColSize, char** stamp, int stampRowSize, int stampColSize) {
    return canStampAll(gridRowSize, gridColSize, stampRowSize, stampColSize, grid, stamp);
}