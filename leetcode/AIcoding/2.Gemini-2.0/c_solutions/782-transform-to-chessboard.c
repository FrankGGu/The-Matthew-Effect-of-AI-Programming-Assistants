#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int movesToChessboard(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int rowMask = 0;
    for (int i = 0; i < n; i++) {
        rowMask |= (board[0][i] << i);
    }

    int rowInvertMask = ((1 << n) - 1) ^ rowMask;
    int rowCnt = 0;
    int rowInvertCnt = 0;
    for (int i = 0; i < n; i++) {
        int mask = 0;
        for (int j = 0; j < n; j++) {
            mask |= (board[i][j] << j);
        }
        if (mask == rowMask) {
            rowCnt++;
        } else if (mask == rowInvertMask) {
            rowInvertCnt++;
        } else {
            return -1;
        }
    }

    if (abs(rowCnt - rowInvertCnt) > 1) {
        return -1;
    }

    int colMask = 0;
    for (int i = 0; i < n; i++) {
        colMask |= (board[i][0] << i);
    }

    int colInvertMask = ((1 << n) - 1) ^ colMask;
    int colCnt = 0;
    int colInvertCnt = 0;
    for (int i = 0; i < n; i++) {
        int mask = 0;
        for (int j = 0; j < n; j++) {
            mask |= (board[j][i] << j);
        }
        if (mask == colMask) {
            colCnt++;
        } else if (mask == colInvertMask) {
            colInvertCnt++;
        } else {
            return -1;
        }
    }

    if (abs(colCnt - colInvertCnt) > 1) {
        return -1;
    }

    int rowSwaps = 0;
    int colSwaps = 0;

    int rowStartWithZero = 0;
    for (int i = 0; i < n; i += 2) {
        if ((rowMask & (1 << i)) != 0) {
            rowStartWithZero++;
        }
    }

    int colStartWithZero = 0;
    for (int i = 0; i < n; i += 2) {
        if ((colMask & (1 << i)) != 0) {
            colStartWithZero++;
        }
    }

    if (n % 2 == 0) {
        rowSwaps = n / 2 - (rowMask & 1 ? rowStartWithZero : (n - rowStartWithZero));
        if (rowSwaps < 0) rowSwaps = -rowSwaps;
        colSwaps = n / 2 - (colMask & 1 ? colStartWithZero : (n - colStartWithZero));
        if (colSwaps < 0) colSwaps = -colSwaps;
    } else {
        rowSwaps = (n / 2) - (rowMask & 1 ? (rowStartWithZero -1 ) : (n - rowStartWithZero - 1));
        if(rowSwaps < 0) rowSwaps = -rowSwaps;
        colSwaps = (n / 2) - (colMask & 1 ? (colStartWithZero - 1) : (n - colStartWithZero - 1));
        if(colSwaps < 0) colSwaps = -colSwaps;
    }

    return (rowSwaps + colSwaps);
}