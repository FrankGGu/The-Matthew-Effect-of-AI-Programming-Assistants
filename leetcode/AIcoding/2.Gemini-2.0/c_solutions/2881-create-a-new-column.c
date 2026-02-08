#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct DataFrame* createNewColumn(struct DataFrame* df, int* column) {
    int newCols = df->cols + 1;
    int* newValues = (int*)malloc(sizeof(int) * df->rows * newCols);

    for (int i = 0; i < df->rows; i++) {
        for (int j = 0; j < df->cols; j++) {
            newValues[i * newCols + j] = df->values[i * df->cols + j];
        }
        newValues[i * newCols + df->cols] = column[i];
    }

    free(df->values);
    df->values = newValues;
    df->cols = newCols;

    return df;
}