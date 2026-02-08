#include <stdio.h>
#include <stdlib.h>

bool isPrintable(int** rect, int rows, int cols) {
    int* rowMin = (int*)malloc(rows * sizeof(int));
    int* rowMax = (int*)malloc(rows * sizeof(int));
    int* colMin = (int*)malloc(cols * sizeof(int));
    int* colMax = (int*)malloc(cols * sizeof(int));

    for (int i = 0; i < rows; ++i) {
        rowMin[i] = cols;
        rowMax[i] = -1;
    }

    for (int j = 0; j < cols; ++j) {
        colMin[j] = rows;
        colMax[j] = -1;
    }

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (rect[i][j] != 0) {
                rowMin[i] = fmin(rowMin[i], j);
                rowMax[i] = fmax(rowMax[i], j);
                colMin[j] = fmin(colMin[j], i);
                colMax[j] = fmax(colMax[j], i);
            }
        }
    }

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (rect[i][j] != 0) {
                if (rowMin[i] > j || rowMax[i] < j || colMin[j] > i || colMax[j] < i) {
                    free(rowMin);
                    free(rowMax);
                    free(colMin);
                    free(colMax);
                    return false;
                }
            }
        }
    }

    free(rowMin);
    free(rowMax);
    free(colMin);
    free(colMax);
    return true;
}