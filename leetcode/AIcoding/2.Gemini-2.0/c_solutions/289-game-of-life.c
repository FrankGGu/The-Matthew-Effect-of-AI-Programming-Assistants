#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void gameOfLife(int** board, int boardSize, int* boardColSize){
    int rows = boardSize;
    int cols = boardColSize[0];
    int** nextBoard = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        nextBoard[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int liveNeighbors = 0;
            for (int x = i - 1; x <= i + 1; x++) {
                for (int y = j - 1; y <= j + 1; y++) {
                    if (x >= 0 && x < rows && y >= 0 && y < cols && !(x == i && y == j)) {
                        liveNeighbors += board[x][y];
                    }
                }
            }

            if (board[i][j] == 1) {
                if (liveNeighbors < 2 || liveNeighbors > 3) {
                    nextBoard[i][j] = 0;
                } else {
                    nextBoard[i][j] = 1;
                }
            } else {
                if (liveNeighbors == 3) {
                    nextBoard[i][j] = 1;
                } else {
                    nextBoard[i][j] = 0;
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            board[i][j] = nextBoard[i][j];
        }
    }

    for (int i = 0; i < rows; i++) {
        free(nextBoard[i]);
    }
    free(nextBoard);
}