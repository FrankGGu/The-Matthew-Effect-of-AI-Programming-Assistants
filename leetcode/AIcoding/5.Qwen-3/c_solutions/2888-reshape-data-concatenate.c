#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int rows;
    int cols;
    int* data;
} Matrix;

Matrix* concat(const Matrix* a, const Matrix* b, int axis) {
    if (axis == 0) {
        if (a->cols != b->cols) {
            return NULL;
        }
        Matrix* result = (Matrix*)malloc(sizeof(Matrix));
        result->rows = a->rows + b->rows;
        result->cols = a->cols;
        result->data = (int*)malloc(result->rows * result->cols * sizeof(int));
        for (int i = 0; i < a->rows * a->cols; i++) {
            result->data[i] = a->data[i];
        }
        for (int i = 0; i < b->rows * b->cols; i++) {
            result->data[a->rows * a->cols + i] = b->data[i];
        }
        return result;
    } else if (axis == 1) {
        if (a->rows != b->rows) {
            return NULL;
        }
        Matrix* result = (Matrix*)malloc(sizeof(Matrix));
        result->rows = a->rows;
        result->cols = a->cols + b->cols;
        result->data = (int*)malloc(result->rows * result->cols * sizeof(int));
        for (int i = 0; i < a->rows; i++) {
            for (int j = 0; j < a->cols; j++) {
                result->data[i * result->cols + j] = a->data[i * a->cols + j];
            }
            for (int j = 0; j < b->cols; j++) {
                result->data[i * result->cols + a->cols + j] = b->data[i * b->cols + j];
            }
        }
        return result;
    }
    return NULL;
}