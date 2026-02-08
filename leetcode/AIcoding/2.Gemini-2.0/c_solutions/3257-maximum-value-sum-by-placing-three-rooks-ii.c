#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long solve(int m, int n, int** board, int* row, int* col) {
    long long max_sum = LLONG_MIN;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (i == row[0] || i == row[1] || i == row[2] || j == col[0] || j == col[1] || j == col[2]) continue;
            for (int k = i + 1; k < m; k++) {
                for (int l = j + 1; l < n; l++) {
                    if (k == row[0] || k == row[1] || k == row[2] || l == col[0] || l == col[1] || l == col[2]) continue;
                    for (int p = k + 1; p < m; p++) {
                        for (int q = l + 1; q < n; q++) {
                            if (p == row[0] || p == row[1] || p == row[2] || q == col[0] || q == col[1] || q == col[2]) continue;
                            long long current_sum = (long long)board[i][j] + board[k][l] + board[p][q];
                            max_sum = max(max_sum, current_sum);
                        }
                    }
                }
            }
        }
    }
    return max_sum;
}

long long maxValue(int** board, int boardSize, int* boardColSize, int* row, int rowSize, int* col, int colSize) {
    return solve(boardSize, boardColSize[0], board, row, col);
}