#include <stdbool.h>
#include <string.h>

bool dfs(char** board, int rows, int cols, int r, int c, char* word, int wordIdx) {
    if (word[wordIdx] == '\0') {
        return true; // Entire word found
    }

    // Check boundary conditions and character match
    if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word[wordIdx]) {
        return false;
    }

    char originalChar = board[r][c];
    board[r][c] = '#'; // Mark as visited to avoid revisiting in the same path

    // Explore all 4 possible directions
    bool found = dfs(board, rows, cols, r + 1, c, word, wordIdx + 1) ||
                 dfs(board, rows, cols, r - 1, c, word, wordIdx + 1) ||
                 dfs(board, rows, cols, r, c + 1, word, wordIdx + 1) ||
                 dfs(board, rows, cols, r, c - 1, word, wordIdx + 1);

    board[r][c] = originalChar; // Backtrack: restore the character
    return found;
}

bool exist(char** board, int boardSize, int* boardColSize, char* word) {
    if (word == NULL || word[0] == '\0') {
        return true; // An empty word is always considered found
    }
    if (boardSize == 0 || boardColSize == NULL || boardColSize[0] == 0) {
        return false; // Empty board, cannot find any non-empty word
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