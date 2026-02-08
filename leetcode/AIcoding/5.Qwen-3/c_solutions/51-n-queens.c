#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** create_board(int n) {
    char** board = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        board[i] = (char*)malloc((n + 1) * sizeof(char));
        memset(board[i], '.', n);
        board[i][n] = '\0';
    }
    return board;
}

void free_board(char** board, int n) {
    for (int i = 0; i < n; i++) {
        free(board[i]);
    }
    free(board);
}

int is_safe(char** board, int row, int col, int n) {
    int i, j;

    for (i = 0; i < row; i++) {
        if (board[i][col] == 'Q') return 0;
    }

    for (i = row, j = col; i >= 0 && j >= 0; i--, j--) {
        if (board[i][j] == 'Q') return 0;
    }

    for (i = row, j = col; i >= 0 && j < n; i--, j++) {
        if (board[i][j] == 'Q') return 0;
    }

    return 1;
}

void solve_n_queens(char*** result, char** board, int* return_size, int n, int row) {
    if (row == n) {
        result[*return_size] = (char**)malloc(n * sizeof(char*));
        for (int i = 0; i < n; i++) {
            result[*return_size][i] = strdup(board[i]);
        }
        (*return_size)++;
        return;
    }

    for (int col = 0; col < n; col++) {
        if (is_safe(board, row, col, n)) {
            board[row][col] = 'Q';
            solve_n_queens(result, board, return_size, n, row + 1);
            board[row][col] = '.';
        }
    }
}

char*** solveNQueens(int n, int* returnSize, int** returnColumnSizes) {
    char*** result = (char***)malloc(sizeof(char**) * 1000);
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(sizeof(int) * 1000);

    char** board = create_board(n);
    solve_n_queens(result, board, returnSize, n, 0);
    free_board(board, n);

    return result;
}