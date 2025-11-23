#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char **data;
    int rows;
    int cols;
} DataFrame;

DataFrame* dropMissingData(DataFrame* df) {
    int *validRows = (int *)malloc(df->rows * sizeof(int));
    int validRowCount = 0;

    for (int i = 0; i < df->rows; i++) {
        int isValid = 1;
        for (int j = 0; j < df->cols; j++) {
            if (df->data[i][j] == NULL || strcmp(df->data[i][j], "") == 0) {
                isValid = 0;
                break;
            }
        }
        if (isValid) {
            validRows[validRowCount++] = i;
        }
    }

    DataFrame *newDf = (DataFrame *)malloc(sizeof(DataFrame));
    newDf->rows = validRowCount;
    newDf->cols = df->cols;
    newDf->data = (char **)malloc(validRowCount * sizeof(char *));

    for (int i = 0; i < validRowCount; i++) {
        newDf->data[i] = (char *)malloc(df->cols * sizeof(char *));
        for (int j = 0; j < df->cols; j++) {
            newDf->data[i][j] = df->data[validRows[i]][j];
        }
    }

    free(validRows);
    return newDf;
}