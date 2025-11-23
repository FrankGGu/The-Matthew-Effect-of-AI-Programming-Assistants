#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COLUMNS 10
#define MAX_STRING_LENGTH 255

typedef struct {
    char** data;
    int rows;
    int cols;
} DataFrame;

DataFrame* dropDuplicates(DataFrame* df) {
    if (df == NULL || df->rows == 0) {
        return df;
    }

    int* keep = (int*)malloc(df->rows * sizeof(int));
    for (int i = 0; i < df->rows; i++) {
        keep[i] = 1;
    }

    for (int i = 0; i < df->rows; i++) {
        if (keep[i] == 0) continue;
        for (int j = i + 1; j < df->rows; j++) {
            if (keep[j] == 0) continue;
            int equal = 1;
            for (int k = 0; k < df->cols; k++) {
                if (strcmp(df->data[i * df->cols + k], df->data[j * df->cols + k]) != 0) {
                    equal = 0;
                    break;
                }
            }
            if (equal) {
                keep[j] = 0;
            }
        }
    }

    int new_rows = 0;
    for (int i = 0; i < df->rows; i++) {
        if (keep[i]) {
            new_rows++;
        }
    }

    char** new_data = (char**)malloc(new_rows * df->cols * sizeof(char*));
    int new_row_index = 0;
    for (int i = 0; i < df->rows; i++) {
        if (keep[i]) {
            for (int j = 0; j < df->cols; j++) {
                new_data[new_row_index * df->cols + j] = df->data[i * df->cols + j];
            }
            new_row_index++;
        }
    }

    free(keep);
    free(df->data);

    df->data = new_data;
    df->rows = new_rows;

    return df;
}