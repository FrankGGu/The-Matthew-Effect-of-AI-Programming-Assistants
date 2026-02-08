#include <stdbool.h>
#include <string.h>

bool isValid(char** board, int row, int col, char c) {
    for (int i = 0; i < 9; i++) {
        if (board[row][i] == c) { // Check row
            return false;
        }
        if (board[i][col] == c) { // Check column
            return false;
        }
        if (board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == c) { // Check 3x3 subgrid
            return false;
        }
    }
    return true;
}

bool solve(char** board) {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (board[i][j] == '.') {
                for (char c = '1'; c <= '9'; c++) {
                    if (isValid(board, i, j, c)) {
                        board[i][j] = c;
                        if (solve(board)) {
                            return true;
                        } else {
                            board[i][j] = '.'; // Backtrack
                        }
                    }
                }
                return false; // No number worked for this cell
            }
        }
    }
    return true; // All cells filled
}

void solveSudoku(char** board, int boardSize, int* boardColSize) {
    solve(board);
}