#include <stdio.h>
#include <stdlib.h>

void solveSudoku(char** board, int boardSize, int* boardColSize) {
    void backtrack(char** board, int* row, int* col);
    int used[9][9];
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (board[i][j] != '.') {
                int num = board[i][j] - '1';
                used[i][num] = 1;
                used[9 + j][num] = 1;
                used[18 + (i / 3) * 3 + j / 3][num] = 1;
            }
        }
    }

    void backtrack(char** board, int* row, int* col) {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] == '.') {
                    *row = i;
                    *col = j;
                    return;
                }
            }
        }
        *row = -1;
        *col = -1;
    }

    void dfs(char** board, int* row, int* col, int* used) {
        if (*row == -1) {
            return;
        }
        int i = *row;
        int j = *col;
        for (int k = 0; k < 9; k++) {
            if (!used[i][k] && !used[9 + j][k] && !used[18 + (i / 3) * 3 + j / 3][k]) {
                board[i][j] = k + '1';
                used[i][k] = 1;
                used[9 + j][k] = 1;
                used[18 + (i / 3) * 3 + j / 3][k] = 1;
                backtrack(board, row, col);
                if (*row == -1) {
                    return;
                }
                board[i][j] = '.';
                used[i][k] = 0;
                used[9 + j][k] = 0;
                used[18 + (i / 3) * 3 + j / 3][k] = 0;
            }
        }
    }

    int row = 0, col = 0;
    backtrack(board, &row, &col);
    while (row != -1) {
        dfs(board, &row, &col, used);
        backtrack(board, &row, &col);
    }
}