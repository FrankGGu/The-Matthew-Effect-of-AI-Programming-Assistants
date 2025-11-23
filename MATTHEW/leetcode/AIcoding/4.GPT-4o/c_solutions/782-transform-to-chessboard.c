#include <stdbool.h>

int movesToChessboard(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int rowCount[2] = {0, 0}, colCount[2] = {0, 0};
    int rowSwapCount = 0, colSwapCount = 0;

    for (int i = 0; i < n; i++) {
        rowCount[board[i][0]]++;
        for (int j = 1; j < n; j++) {
            if (board[i][j] == board[i][j - 1]) return -1;
        }
    }

    for (int j = 0; j < n; j++) {
        colCount[board[0][j]]++;
        for (int i = 1; i < n; i++) {
            if (board[i][j] == board[i - 1][j]) return -1;
        }
    }

    if ((rowCount[0] != n / 2 && rowCount[0] != (n + 1) / 2) || 
        (colCount[0] != n / 2 && colCount[0] != (n + 1) / 2)) {
        return -1;
    }

    for (int i = 0; i < n; i++) {
        if (board[i][0] == i % 2) rowSwapCount++;
        if (board[0][i] == i % 2) colSwapCount++;
    }

    if (n % 2 == 0) {
        rowSwapCount = rowSwapCount < n - rowSwapCount ? rowSwapCount : n - rowSwapCount;
        colSwapCount = colSwapCount < n - colSwapCount ? colSwapCount : n - colSwapCount;
    } else {
        rowSwapCount = rowSwapCount < n - rowSwapCount ? rowSwapCount : n - rowSwapCount;
        colSwapCount = colSwapCount < n - colSwapCount ? colSwapCount : n - colSwapCount;
    }

    return rowSwapCount + colSwapCount;
}