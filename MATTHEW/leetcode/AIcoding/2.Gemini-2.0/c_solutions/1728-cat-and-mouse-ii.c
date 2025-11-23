#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int catMouse(int height, int width, int food[], int mouse[], int cat[], int mouseJump, int catJump) {
    int memo[height][width][height][width][2][1001];
    memset(memo, -1, sizeof(memo));

    bool canWin(int mRow, int mCol, int cRow, int cCol, int turn, int moves) {
        if (moves > 1000) {
            return false;
        }

        if (memo[mRow][mCol][cRow][cCol][turn][moves] != -1) {
            return memo[mRow][mCol][cRow][cCol][turn][moves];
        }

        if (mRow == food[0] && mCol == food[1]) {
            memo[mRow][mCol][cRow][cCol][turn][moves] = true;
            return true;
        }

        if (mRow == cRow && mCol == cCol) {
            memo[mRow][mCol][cRow][cCol][turn][moves] = false;
            return false;
        }

        if (turn == 0) { // Mouse's turn
            for (int i = -mouseJump; i <= mouseJump; i++) {
                for (int j = -mouseJump; j <= mouseJump; j++) {
                    int newMRow = mRow + i;
                    int newMCol = mCol + j;

                    if (newMRow >= 0 && newMRow < height && newMCol >= 0 && newMCol < width) {
                        if (canWin(newMRow, newMCol, cRow, cCol, 1, moves + 1)) {
                            memo[mRow][mCol][cRow][cCol][turn][moves] = true;
                            return true;
                        }
                    }
                }
            }
            memo[mRow][mCol][cRow][cCol][turn][moves] = false;
            return false;
        } else { // Cat's turn
            for (int i = -catJump; i <= catJump; i++) {
                for (int j = -catJump; j <= catJump; j++) {
                    int newCRow = cRow + i;
                    int newCCol = cCol + j;

                    if (newCRow >= 0 && newCRow < height && newCCol >= 0 && newCCol < width) {
                        if (!canWin(mRow, mCol, newCRow, newCCol, 0, moves + 1)) {
                            memo[mRow][mCol][cRow][cCol][turn][moves] = false;
                            return false;
                        }
                    }
                }
            }
            memo[mRow][mCol][cRow][cCol][turn][moves] = true;
            return true;
        }
    }

    return canWin(mouse[0], mouse[1], cat[0], cat[1], 0, 0);
}