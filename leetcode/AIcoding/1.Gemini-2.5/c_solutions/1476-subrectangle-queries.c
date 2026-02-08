#include <stdlib.h>

typedef struct {
    int** rect;
    int rows;
    int cols;
} SubrectangleQueries;

SubrectangleQueries* subrectangleQueriesCreate(int** rectangle, int rectangleSize, int* rectangleColSize) {
    SubrectangleQueries* obj = (SubrectangleQueries*) malloc(sizeof(SubrectangleQueries));
    obj->rows = rectangleSize;
    obj->cols = rectangleColSize[0];

    obj->rect = (int**) malloc(obj->rows * sizeof(int*));
    for (int i = 0; i < obj->rows; i++) {
        obj->rect[i] = (int*) malloc(obj->cols * sizeof(int));
        for (int j = 0; j < obj->cols; j++) {
            obj->rect[i][j] = rectangle[i][j];
        }
    }
    return obj;
}

void subrectangleQueriesUpdateSubrectangle(SubrectangleQueries* obj, int row1, int col1, int row2, int col2, int newValue) {
    for (int i = row1; i <= row2; i++) {
        for (int j = col1; j <= col2; j++) {
            obj->rect[i][j] = newValue;
        }
    }
}

int subrectangleQueriesGet(SubrectangleQueries* obj, int row, int col) {
    return obj->rect[row][col];
}

void subrectangleQueriesFree(SubrectangleQueries* obj) {
    if (obj == NULL) return;
    if (obj->rect != NULL) {
        for (int i = 0; i < obj->rows; i++) {
            free(obj->rect[i]);
        }
        free(obj->rect);
    }
    free(obj);
}