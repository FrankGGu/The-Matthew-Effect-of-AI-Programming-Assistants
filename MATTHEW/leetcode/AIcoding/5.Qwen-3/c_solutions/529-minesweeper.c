#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void updateBoard(char** board, int rows, int cols, int r, int c) {
    if (r < 0 || c < 0 || r >= rows || c >= cols || board[r][c] != 'M' && board[r][c] != 'E') return;
    if (board[r][c] == 'M') {
        board[r][c] = 'X';
        return;
    }
    int count = 0;
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            if (i == 0 && j == 0) continue;
            int nr = r + i;
            int nc = c + j;
            if (nr >= 0 && nc >= 0 && nr < rows && nc < cols && board[nr][nc] == 'M') count++;
        }
    }
    if (count > 0) {
        board[r][c] = '0' + count;
        return;
    }
    board[r][c] = 'B';
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            if (i == 0 && j == 0) continue;
            updateBoard(board, rows, cols, r + i, c + j);
        }
    }
}

char** updateBoard(char** board, int rows, int cols, int r, int c) {
    updateBoard(board, rows, cols, r, c);
    return board;
}