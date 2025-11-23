#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBattleships(char** board, int boardSize, int* boardColSize) {
    int count = 0;
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[0]; j++) {
            if (board[i][j] == 'X') {
                if ((i > 0 && board[i - 1][j] == 'X') || (j > 0 && board[i][j - 1] == 'X')) {
                    continue;
                }
                count++;
            }
        }
    }
    return count;
}