#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool dfs(char** board, int m, int n, char* word, int i, int j, int index) {
    if (index == strlen(word)) return true;
    if (i < 0 || j < 0 || i >= m || j >= n || board[i][j] != word[index]) return false;

    char temp = board[i][j];
    board[i][j] = '#';

    bool found = dfs(board, m, n, word, i+1, j, index+1) ||
                  dfs(board, m, n, word, i-1, j, index+1) ||
                  dfs(board, m, n, word, i, j+1, index+1) ||
                  dfs(board, m, n, word, i, j-1, index+1);

    board[i][j] = temp;
    return found;
}

bool exist(char** board, int boardSize, int* boardColSize, char* word) {
    int m = boardSize;
    int n = boardColSize[0];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (dfs(board, m, n, word, i, j, 0)) return true;
        }
    }
    return false;
}