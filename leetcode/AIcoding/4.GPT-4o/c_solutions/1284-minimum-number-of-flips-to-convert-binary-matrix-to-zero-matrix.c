#include <stdbool.h>

int minFlips(int** mat, int matSize, int* matColSize) {
    int row = matSize, col = *matColSize;
    int totalStates = 1 << (row * col);
    int target = 0, minFlips = totalStates;
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            target |= (mat[i][j] << (i * col + j));
        }
    }

    for (int state = 0; state < totalStates; state++) {
        int flipCount = 0;
        int current = state;
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                if (current & (1 << (i * col + j))) {
                    flipCount++;
                    for (int di = -1; di <= 1; di++) {
                        for (int dj = -1; dj <= 1; dj++) {
                            if (abs(di) + abs(dj) == 1) {
                                int ni = i + di, nj = j + dj;
                                if (ni >= 0 && ni < row && nj >= 0 && nj < col) {
                                    current ^= (1 << (ni * col + nj));
                                }
                            }
                        }
                    }
                    current ^= (1 << (i * col + j));
                }
            }
        }
        if (current == target) {
            minFlips = flipCount < minFlips ? flipCount : minFlips;
        }
    }
    return minFlips == totalStates ? -1 : minFlips;
}