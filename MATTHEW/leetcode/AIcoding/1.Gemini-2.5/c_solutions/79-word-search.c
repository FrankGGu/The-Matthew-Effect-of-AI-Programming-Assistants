#include <stdbool.h>
#include <string.h>

bool dfs(char** board, int boardRowSize, int boardColSize, int r, int c, char* word, int wordLen, int wordIdx) {
    if (wordIdx == wordLen) {
        return true;
    }

    if (r < 0 || r >= boardRowSize || c < 0 || c >= boardColSize || board[r][c] != word[wordIdx]) {
        return false;
    }

    char originalChar = board[r][c];
    board[r][c] = '#'; 

    bool found = dfs(board, boardRowSize, boardColSize, r + 1, c, word, wordLen, wordIdx + 1) ||
                 dfs(board, boardRowSize, boardColSize, r - 1, c, word, wordLen, wordIdx + 1) ||
                 dfs(board, boardRowSize, boardColSize, r, c + 1, word, wordLen, wordIdx + 1) ||
                 dfs(board, boardRowSize, boardColSize, r, c - 1, word, wordLen, wordIdx + 1);

    board[r][c] = originalChar; 

    return found;
}

bool exist(char** board, int boardRowSize, int* boardColSize, char* word) {
    int wordLen = strlen(word);
    if (wordLen == 0) {
        return true;
    }

    int numCols = boardColSize[0];

    for (int r = 0; r < boardRowSize; r++) {
        for (int c = 0; c < numCols; c++) {
            if (board[r][c] == word[0]) {
                if (dfs(board, boardRowSize, numCols, r, c, word, wordLen, 0)) {
                    return true;
                }
            }
        }
    }
    return false;
}