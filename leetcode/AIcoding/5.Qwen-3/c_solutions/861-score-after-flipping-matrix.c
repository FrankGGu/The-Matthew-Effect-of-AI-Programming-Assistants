#include <stdio.h>
#include <stdlib.h>

int matrixScore(int** A, int ASize, int* AColSize) {
    int rows = ASize;
    int cols = AColSize[0];

    for (int i = 0; i < rows; i++) {
        if (A[i][0] == 0) {
            for (int j = 0; j < cols; j++) {
                A[i][j] ^= 1;
            }
        }
    }

    for (int j = 1; j < cols; j++) {
        int count = 0;
        for (int i = 0; i < rows; i++) {
            count += A[i][j];
        }
        if (count < rows - count) {
            for (int i = 0; i < rows; i++) {
                A[i][j] ^= 1;
            }
        }
    }

    int score = 0;
    for (int i = 0; i < rows; i++) {
        int val = 0;
        for (int j = 0; j < cols; j++) {
            val = val * 2 + A[i][j];
        }
        score += val;
    }

    return score;
}