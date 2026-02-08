#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct DataFrame {
    int rows;
    int cols;
    double **data;
};

struct DataFrame* dropMissingData(struct DataFrame* df) {
    int rows = df->rows;
    int cols = df->cols;
    double **data = df->data;

    int new_rows = 0;
    for (int i = 0; i < rows; i++) {
        int has_missing = 0;
        for (int j = 0; j < cols; j++) {
            if (data[i][j] != data[i][j]) {
                has_missing = 1;
                break;
            }
        }
        if (!has_missing) {
            new_rows++;
        }
    }

    double **new_data = (double **)malloc(new_rows * sizeof(double *));
    int k = 0;
    for (int i = 0; i < rows; i++) {
        int has_missing = 0;
        for (int j = 0; j < cols; j++) {
            if (data[i][j] != data[i][j]) {
                has_missing = 1;
                break;
            }
        }
        if (!has_missing) {
            new_data[k] = (double *)malloc(cols * sizeof(double));
            for (int j = 0; j < cols; j++) {
                new_data[k][j] = data[i][j];
            }
            k++;
        }
    }

    for(int i = 0; i < rows; i++){
        free(data[i]);
    }
    free(data);

    struct DataFrame* new_df = (struct DataFrame*)malloc(sizeof(struct DataFrame));
    new_df->rows = new_rows;
    new_df->cols = cols;
    new_df->data = new_data;

    return new_df;
}