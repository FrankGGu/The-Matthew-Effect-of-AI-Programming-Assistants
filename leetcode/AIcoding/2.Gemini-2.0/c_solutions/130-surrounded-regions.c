#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void solve(char** board, int boardSize, int* boardColSize){
    if (boardSize == 0) return;
    int rows = boardSize;
    int cols = boardColSize[0];

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != 'O') {
            return;
        }
        board[r][c] = '#';
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    for (int i = 0; i < rows; i++) {
        if (board[i][0] == 'O') {
            dfs(i, 0);
        }
        if (board[i][cols - 1] == 'O') {
            dfs(i, cols - 1);
        }
    }

    for (int j = 0; j < cols; j++) {
        if (board[0][j] == 'O') {
            dfs(0, j);
        }
        if (board[rows - 1][j] == 'O') {
            dfs(rows - 1, j);
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == 'O') {
                board[i][j] = 'X';
            } else if (board[i][j] == '#') {
                board[i][j] = 'O';
            }
        }
    }
}