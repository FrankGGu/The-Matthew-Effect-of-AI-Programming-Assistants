#include <stdio.h>
#include <stdlib.h>

#define N 8

int isSafe(int x, int y, int board[N][N]) {
    return (x >= 0 && x < N && y >= 0 && y < N && board[x][y] == -1);
}

int solveKTUtil(int board[N][N], int movei, int x, int y, int fx, int fy, int dx[], int dy[]) {
    int next_x, next_y, i;
    if (movei == N * N)
        return 1;

    for (i = 0; i < 8; i++) {
        next_x = x + dx[i];
        next_y = y + dy[i];
        if (isSafe(next_x, next_y, board)) {
            board[next_x][next_y] = movei;
            if (solveKTUtil(board, movei + 1, next_x, next_y, fx, fy, dx, dy))
                return 1;
            board[next_x][next_y] = -1;
        }
    }
    return 0;
}

int solveKT(int x, int y, int fx, int fy) {
    int board[N][N];
    int dx[] = {2, 1, -1, -2, -2, -1, 1, 2};
    int dy[] = {1, 2, 2, 1, -1, -2, -2, -1};
    int i, j;

    for (i = 0; i < N; i++)
        for (j = 0; j < N; j++)
            board[i][j] = -1;

    board[x][y] = 0;

    if (solveKTUtil(board, 1, x, y, fx, fy, dx, dy) == 1)
        return 1;
    else
        return 0;
}