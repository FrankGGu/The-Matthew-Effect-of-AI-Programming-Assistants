#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maze[100][100];
int rows, cols;
bool visited[100][100];

bool isValid(int row, int col) {
    return (row >= 0 && row < rows && col >= 0 && col < cols && maze[row][col] == 0 && !visited[row][col]);
}

bool solveMazeUtil(int row, int col, int destRow, int destCol) {
    if (row == destRow && col == destCol) {
        return true;
    }

    visited[row][col] = true;

    int rowMoves[] = {0, 0, 1, -1};
    int colMoves[] = {1, -1, 0, 0};

    for (int i = 0; i < 4; i++) {
        int newRow = row + rowMoves[i];
        int newCol = col + colMoves[i];

        if (isValid(newRow, newCol)) {
            if (solveMazeUtil(newRow, newCol, destRow, destCol)) {
                return true;
            }
        }
    }

    return false;
}

bool solveMaze(int startRow, int startCol, int destRow, int destCol, int maze_data[][100], int rows_val, int cols_val) {
    rows = rows_val;
    cols = cols_val;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            maze[i][j] = maze_data[i][j];
            visited[i][j] = false;
        }
    }

    return solveMazeUtil(startRow, startCol, destRow, destCol);
}