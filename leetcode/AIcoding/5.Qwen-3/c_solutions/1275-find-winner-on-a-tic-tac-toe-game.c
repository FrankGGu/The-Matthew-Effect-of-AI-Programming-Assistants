#include <stdio.h>
#include <stdlib.h>

char* tictactoe(int** moves, int movesSize, int* movesColSize) {
    char board[3][3];
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            board[i][j] = ' ';
        }
    }

    for (int i = 0; i < movesSize; i++) {
        int row = moves[i][0];
        int col = moves[i][1];
        if (i % 2 == 0) {
            board[row][col] = 'A';
        } else {
            board[row][col] = 'B';
        }
    }

    // Check rows
    for (int i = 0; i < 3; i++) {
        if (board[i][0] != ' ' && board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
            return (board[i][0] == 'A') ? "A" : "B";
        }
    }

    // Check columns
    for (int j = 0; j < 3; j++) {
        if (board[0][j] != ' ' && board[0][j] == board[1][j] && board[1][j] == board[2][j]) {
            return (board[0][j] == 'A') ? "A" : "B";
        }
    }

    // Check diagonals
    if (board[0][0] != ' ' && board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
        return (board[0][0] == 'A') ? "A" : "B";
    }
    if (board[0][2] != ' ' && board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
        return (board[0][2] == 'A') ? "A" : "B";
    }

    // If no winner, check if all moves are done
    if (movesSize == 9) {
        return "Draw";
    } else {
        return "Pending";
    }
}