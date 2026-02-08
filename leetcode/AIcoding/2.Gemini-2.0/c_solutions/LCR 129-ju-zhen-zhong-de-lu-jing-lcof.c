#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool exist(char** board, int boardSize, int* boardColSize, char* word) {
    int rows = boardSize;
    int cols = boardColSize[0];
    int wordLen = strlen(word);

    bool dfs(int row, int col, int index) {
        if (index == wordLen) {
            return true;
        }

        if (row < 0 || row >= rows || col < 0 || col >= cols || board[row][col] != word[index]) {
            return false;
        }

        char temp = board[row][col];
        board[row][col] = '\0'; 

        bool found = dfs(row + 1, col, index + 1) ||
                     dfs(row - 1, col, index + 1) ||
                     dfs(row, col + 1, index + 1) ||
                     dfs(row, col - 1, index + 1);

        board[row][col] = temp; 
        return found;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (dfs(i, j, 0)) {
                return true;
            }
        }
    }

    return false;
}