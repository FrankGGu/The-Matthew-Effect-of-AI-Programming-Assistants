#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** generateBoard(char* moves, int rows, int cols) {
    char** board = (char**)malloc(rows * sizeof(char*));
    for (int i = 0; i < rows; i++) {
        board[i] = (char*)malloc(cols * sizeof(char));
        for (int j = 0; j < cols; j++) {
            board[i][j] = ' ';
        }
    }

    int moveIndex = 0;
    int row = 0, col = 0;
    while (moveIndex < strlen(moves)) {
        char move = moves[moveIndex];
        if (move == 'U') row--;
        else if (move == 'D') row++;
        else if (move == 'L') col--;
        else if (move == 'R') col++;
        else if (move == 'B') {
            board[row][col] = 'X';
        }
        moveIndex++;
    }

    return board;
}

int isLegalMove(char** board, int rows, int cols, int r, int c) {
    if (r < 0 || r >= rows || c < 0 || c >= cols) return 0;
    return board[r][c] == ' ';
}

int checkMove(char* moves, int rows, int cols) {
    char** board = generateBoard(moves, rows, cols);
    int moveIndex = 0;
    int row = 0, col = 0;
    while (moveIndex < strlen(moves)) {
        char move = moves[moveIndex];
        if (move == 'U') {
            if (!isLegalMove(board, rows, cols, row - 1, col)) {
                for (int i = 0; i < rows; i++) free(board[i]);
                free(board);
                return 0;
            }
            row--;
        } else if (move == 'D') {
            if (!isLegalMove(board, rows, cols, row + 1, col)) {
                for (int i = 0; i < rows; i++) free(board[i]);
                free(board);
                return 0;
            }
            row++;
        } else if (move == 'L') {
            if (!isLegalMove(board, rows, cols, row, col - 1)) {
                for (int i = 0; i < rows; i++) free(board[i]);
                free(board);
                return 0;
            }
            col--;
        } else if (move == 'R') {
            if (!isLegalMove(board, rows, cols, row, col + 1)) {
                for (int i = 0; i < rows; i++) free(board[i]);
                free(board);
                return 0;
            }
            col++;
        } else if (move == 'B') {
            if (board[row][col] != ' ') {
                for (int i = 0; i < rows; i++) free(board[i]);
                free(board);
                return 0;
            }
            board[row][col] = 'X';
        }
        moveIndex++;
    }

    for (int i = 0; i < rows; i++) free(board[i]);
    free(board);
    return 1;
}