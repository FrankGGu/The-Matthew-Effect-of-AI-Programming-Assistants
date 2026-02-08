#include <stdbool.h>
#include <string.h>

bool dfs(char** board, int rows, int cols, int r, int c, char* word, int wordIdx) {
    if (word[wordIdx] == '\0') {
        return true;
    }

    if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word[wordIdx]) {
        return false;
    }

    char originalChar = board[r][c];
    board[r][c] = '#';

    bool found = dfs(board, rows, cols, r + 1, c, word, wordIdx + 1) ||
                 dfs(board, rows, cols, r - 1, c, word, wordIdx + 1) ||
                 dfs(board, rows, cols, r, c + 1, word, wordIdx + 1) ||
                 dfs(board, rows, cols, r, c - 1, word, wordIdx + 1);

    board[r][c] = originalChar;

    return found;
}

bool exist(char** board, int boardSize, int* boardColSize, char* word) {
    if (boardSize == 0 || boardColSize == NULL || word == NULL) {
        return false;
    }
    if (word[0] == '\0') {
        return true;
    }

    int rows = boardSize;
    int cols = boardColSize[0];

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (board[r][c] == word[0]) {
                if (dfs(board, rows, cols, r, c, word, 0)) {
                    return true;
                }
            }
        }
    }

    return false;
}