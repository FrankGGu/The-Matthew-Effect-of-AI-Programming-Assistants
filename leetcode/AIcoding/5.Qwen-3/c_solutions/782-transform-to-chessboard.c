#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int movesToChessboard(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int i, j;
    int rowSwaps = 0, colSwaps = 0;
    int rowDiff = 0, colDiff = 0;

    for (i = 0; i < n; i++) {
        if (board[i][0] != (i % 2 == 0 ? 0 : 1)) {
            rowDiff++;
        }
    }

    for (i = 0; i < n; i++) {
        if (board[0][i] != (i % 2 == 0 ? 0 : 1)) {
            colDiff++;
        }
    }

    if (rowDiff % 2 != 0 || colDiff % 2 != 0) {
        return -1;
    }

    for (i = 0; i < n; i++) {
        if (board[i][0] != (i % 2 == 0 ? 0 : 1)) {
            rowSwaps++;
        }
    }

    for (i = 0; i < n; i++) {
        if (board[0][i] != (i % 2 == 0 ? 0 : 1)) {
            colSwaps++;
        }
    }

    if (n % 2 == 1) {
        if (rowDiff != 0 && rowDiff != n) {
            return -1;
        }
        if (colDiff != 0 && colDiff != n) {
            return -1;
        }
        return (rowSwaps / 2) + (colSwaps / 2);
    } else {
        if (rowDiff != n / 2 && rowDiff != n / 2) {
            return -1;
        }
        if (colDiff != n / 2 && colDiff != n / 2) {
            return -1;
        }
        return (rowSwaps / 2) + (colSwaps / 2);
    }
}