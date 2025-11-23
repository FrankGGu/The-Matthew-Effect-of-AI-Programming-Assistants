#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areSimilar(int** mat, int matSize, int* matColSize, int k) {
    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < matColSize[i]; j++) {
            if (mat[i][j] != mat[i][(j + k) % matColSize[i]]) {
                return false;
            }
        }
    }
    return true;
}