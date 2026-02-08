#include <stdio.h>
#include <stdlib.h>

int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    int rows = pointsSize;
    int cols = *pointsColSize;

    int* prev = (int*)malloc(cols * sizeof(int));
    for (int j = 0; j < cols; j++) {
        prev[j] = points[0][j];
    }

    for (int i = 1; i < rows; i++) {
        int* curr = (int*)malloc(cols * sizeof(int));
        int* left = (int*)malloc(cols * sizeof(int));
        int* right = (int*)malloc(cols * sizeof(int));

        left[0] = prev[0];
        for (int j = 1; j < cols; j++) {
            left[j] = fmax(left[j - 1] - 1, prev[j]);
        }

        right[cols - 1] = prev[cols - 1];
        for (int j = cols - 2; j >= 0; j--) {
            right[j] = fmax(right[j + 1] - 1, prev[j]);
        }

        for (int j = 0; j < cols; j++) {
            curr[j] = points[i][j] + fmax(left[j], right[j]);
        }

        free(prev);
        prev = curr;
        free(left);
        free(right);
    }

    int result = prev[0];
    for (int j = 1; j < cols; j++) {
        if (prev[j] > result) {
            result = prev[j];
        }
    }

    free(prev);
    return result;
}