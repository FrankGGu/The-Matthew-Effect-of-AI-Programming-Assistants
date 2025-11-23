#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool isValidSudoku(char** board, int boardSize, int* boardColSize) {
    bool rows[9][9] = {false};
    bool cols[9][9] = {false};
    bool boxes[9][9] = {false};

    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            char c = board[i][j];
            if (c == '.') continue;
            int num = c - '1';
            int boxIndex = (i / 3) * 3 + (j / 3);
            if (rows[i][num] || cols[j][num] || boxes[boxIndex][num]) {
                return false;
            }
            rows[i][num] = true;
            cols[j][num] = true;
            boxes[boxIndex][num] = true;
        }
    }
    return true;
}