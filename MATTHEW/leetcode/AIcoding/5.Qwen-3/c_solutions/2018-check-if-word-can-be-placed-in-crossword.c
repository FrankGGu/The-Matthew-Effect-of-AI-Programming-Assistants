#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool placeWordInCrossword(char** board, int boardSize, int* boardColSize, char* word) {
    int wordLen = strlen(word);
    int rows = boardSize;
    int cols = boardColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == '#') continue;

            bool valid = true;
            int k = 0;

            while (k < wordLen) {
                if (i + k >= rows || j + k >= cols || board[i + k][j + k] != word[k]) {
                    valid = false;
                    break;
                }
                k++;
            }

            if (valid) return true;

            valid = true;
            k = 0;

            while (k < wordLen) {
                if (i - k < 0 || j + k >= cols || board[i - k][j + k] != word[k]) {
                    valid = false;
                    break;
                }
                k++;
            }

            if (valid) return true;

            valid = true;
            k = 0;

            while (k < wordLen) {
                if (i + k >= rows || j - k < 0 || board[i + k][j - k] != word[k]) {
                    valid = false;
                    break;
                }
                k++;
            }

            if (valid) return true;

            valid = true;
            k = 0;

            while (k < wordLen) {
                if (i - k < 0 || j - k < 0 || board[i - k][j - k] != word[k]) {
                    valid = false;
                    break;
                }
                k++;
            }

            if (valid) return true;
        }
    }

    return false;
}