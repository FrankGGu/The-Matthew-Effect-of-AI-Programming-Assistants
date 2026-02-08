#include <stdlib.h>
#include <string.h>

typedef struct {
    int** data;
    int numRows;
    int numCols;
    char** columnNames;
} DataFrame;

DataFrame* createDataFrame(int** data, int dataSize, int* dataColSize, char** columnNames, int columnNamesSize) {
    DataFrame* df = (DataFrame*)malloc(sizeof(DataFrame));
    if (df == NULL) {
        return NULL;
    }

    df->numRows = dataSize;
    df->numCols = columnNamesSize;

    if (df->numRows > 0 && df->numCols > 0) {
        df->data = (int**)malloc(df->numRows * sizeof(int*));
        if (df->data == NULL) {
            free(df);
            return NULL;
        }
        for (int i = 0; i < df->numRows; i++) {
            df->data[i] = (int*)malloc(df->numCols * sizeof(int));
            if (df->data[i] == NULL) {
                for (int j = 0; j < i; j++) {
                    free(df->data[j]);
                }
                free(df->data);
                free(df);
                return NULL;
            }
            for (int j = 0; j < df->numCols; j++) {
                df->data[i][j] = data[i][j];
            }
        }
    } else {
        df->data = NULL;
    }

    if (df->numCols > 0) {
        df->columnNames = (char**)malloc(df->numCols * sizeof(char*));
        if (df->columnNames == NULL) {
            if (df->data != NULL) {
                for (int i = 0; i < df->numRows; i++) {
                    free(df->data[i]);
                }
                free(df->data);
            }
            free(df);
            return NULL;
        }
        for (int i = 0; i < df->numCols; i++) {
            df->columnNames[i] = (char*)malloc((strlen(columnNames[i]) + 1) * sizeof(char));
            if (df->columnNames[i] == NULL) {
                for (int j = 0; j < i; j++) {
                    free(df->columnNames[j]);
                }
                free(df->columnNames);
                if (df->data != NULL) {
                    for (int k = 0; k < df->numRows; k++) {
                        free(df->data[k]);
                    }
                    free(df->data);
                }
                free(df);
                return NULL;
            }
            strcpy(df->columnNames[i], columnNames[i]);
        }
    } else {
        df->columnNames = NULL;
    }

    return df;
}