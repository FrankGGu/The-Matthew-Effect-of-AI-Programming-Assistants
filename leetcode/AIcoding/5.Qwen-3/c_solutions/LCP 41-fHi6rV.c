#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 100

typedef struct {
    int row;
    int col;
} Position;

int directions[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

int isWithinBounds(char board[MAX_SIZE][MAX_SIZE], int n, int r, int c) {
    return r >= 0 && r < n && c >= 0 && c < n;
}

int countFlips(char board[MAX_SIZE][MAX_SIZE], int n, int r, int c, char color) {
    int count = 0;
    for (int d = 0; d < 8; d++) {
        int dr = directions[d][0];
        int dc = directions[d][1];
        int nr = r + dr;
        int nc = c + dc;
        int flips = 0;
        while (isWithinBounds(board, n, nr, nc) && board[nr][nc] != color && board[nr][nc] != '.') {
            flips++;
            nr += dr;
            nc += dc;
        }
        if (isWithinBounds(board, n, nr, nc) && board[nr][nc] == color && flips > 0) {
            count += flips;
        }
    }
    return count;
}

int flipChess(char board[MAX_SIZE][MAX_SIZE], int n) {
    int maxFlips = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (board[i][j] == '.') {
                int flips = countFlips(board, n, i, j, 'B');
                if (flips > maxFlips) {
                    maxFlips = flips;
                }
            }
        }
    }
    return maxFlips;
}