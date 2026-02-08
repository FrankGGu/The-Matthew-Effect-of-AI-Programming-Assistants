#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int** rectangle;
    int rows;
    int cols;
} SubrectangleQueries;

SubrectangleQueries* subrectangleQueriesCreate(int** rectangle, int rectangleSize, int* rectangleColSize) {
    SubrectangleQueries* obj = (SubrectangleQueries*)malloc(sizeof(SubrectangleQueries));
    obj->rows = rectangleSize;
    obj->cols = rectangleColSize[0];
    obj->rectangle = (int**)malloc(rectangleSize * sizeof(int*));
    for (int i = 0; i < rectangleSize; i++) {
        obj->rectangle[i] = (int*)malloc(obj->cols * sizeof(int));
        for (int j = 0; j < obj->cols; j++) {
            obj->rectangle[i][j] = rectangle[i][j];
        }
    }
    return obj;
}

void subrectangleQueriesUpdateValue(SubrectangleQueries* obj, int row1, int col1, int row2, int col2, int newValue) {
    for (int i = row1; i <= row2; i++) {
        for (int j = col1; j <= col2; j++) {
            obj->rectangle[i][j] = newValue;
        }
    }
}

int subrectangleQueriesGetRow(SubrectangleQueries* obj, int row) {
    int* result = (int*)malloc(obj->cols * sizeof(int));
    for (int j = 0; j < obj->cols; j++) {
        result[j] = obj->rectangle[row][j];
    }
    return *result;
}

int subrectangleQueriesGetColumn(SubrectangleQueries* obj, int col) {
    int* result = (int*)malloc(obj->rows * sizeof(int));
    for (int i = 0; i < obj->rows; i++) {
        result[i] = obj->rectangle[i][col];
    }
    return *result;
}

int subrectangleQueriesGetValue(SubrectangleQueries* obj, int row, int col) {
    return obj->rectangle[row][col];
}

void subrectangleQueriesFree(SubrectangleQueries* obj) {
    for (int i = 0; i < obj->rows; i++) {
        free(obj->rectangle[i]);
    }
    free(obj->rectangle);
    free(obj);
}