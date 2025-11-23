#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int** matrix;
    int matrixSize;
    int* matrixColSize;
} Solution;

Solution* solutionCreate(int** matrix, int matrixSize, int* matrixColSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->matrix = matrix;
    obj->matrixSize = matrixSize;
    obj->matrixColSize = matrixColSize;
    return obj;
}

void solutionFree(Solution* obj) {
    free(obj);
}

int getDifference(int** matrix, int matrixSize, int* matrixColSize) {
    int i, j;
    int diag1[200], diag2[200];
    int count1 = 0, count2 = 0;
    int unique1[200], unique2[200];

    for (i = 0; i < matrixSize; i++) {
        for (j = 0; j < matrixColSize[i]; j++) {
            int val1 = matrix[i][j];
            int val2 = matrix[i][j];

            if (i - j == 0) {
                int found = 0;
                for (int k = 0; k < count1; k++) {
                    if (unique1[k] == val1) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    unique1[count1++] = val1;
                }
            } else {
                int found = 0;
                for (int k = 0; k < count2; k++) {
                    if (unique2[k] == val2) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    unique2[count2++] = val2;
                }
            }
        }
    }

    return abs(count1 - count2);
}