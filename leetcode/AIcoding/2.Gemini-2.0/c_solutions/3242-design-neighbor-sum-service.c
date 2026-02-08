#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int rows;
    int cols;
    int* mat;
} MGraph;

MGraph* MGraphCreate(int rows, int cols, int* mat, int matSize) {
    MGraph* obj = (MGraph*)malloc(sizeof(MGraph));
    obj->rows = rows;
    obj->cols = cols;
    obj->mat = (int*)malloc(rows * cols * sizeof(int));
    for (int i = 0; i < rows * cols; i++) {
        obj->mat[i] = mat[i];
    }
    return obj;
}

void MGraphUpdate(MGraph* obj, int row, int col, int val) {
    obj->mat[row * obj->cols + col] = val;
}

int MGraphGet(MGraph* obj, int row, int col) {
    int sum = 0;
    for (int i = row - 1; i <= row + 1; i++) {
        for (int j = col - 1; j <= col + 1; j++) {
            if (i >= 0 && i < obj->rows && j >= 0 && j < obj->cols) {
                sum += obj->mat[i * obj->cols + j];
            }
        }
    }
    return sum;
}

void MGraphFree(MGraph* obj) {
    free(obj->mat);
    free(obj);
}