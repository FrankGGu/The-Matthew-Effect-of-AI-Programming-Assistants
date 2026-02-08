#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void updateBoard(char** board, int boardSize, int* boardColSize, int row, int col) {
    if (row < 0 || row >= boardSize || col < 0 || col >= boardColSize[0] || board[row][col] != 'E') {
        return;
    }

    int mines = 0;
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            if (i == 0 && j == 0) continue;
            int newRow = row + i;
            int newCol = col + j;
            if (newRow >= 0 && newRow < boardSize && newCol >= 0 && newCol < boardColSize[0] && board[newRow][newCol] == 'M') {
                mines++;
            }
        }
    }

    if (mines > 0) {
        board[row][col] = mines + '0';
    } else {
        board[row][col] = 'B';
        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                if (i == 0 && j == 0) continue;
                updateBoard(board, boardSize, boardColSize, row + i, col + j);
            }
        }
    }
}

char** updateBoard(char** board, int boardSize, int* boardColSize, int row, int col) {
    if (board[row][col] == 'M') {
        board[row][col] = 'X';
        return board;
    }

    updateBoard(board, boardSize, boardColSize, row, col);
    return board;
}