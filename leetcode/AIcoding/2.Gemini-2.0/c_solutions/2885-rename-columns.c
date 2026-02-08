#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COLS 100

typedef struct {
    char** columnNames;
    int numRows;
    int numCols;
    int* dtypes;
    void** data;
} DataFrame;

DataFrame* renameColumns(DataFrame* df, char** oldColumnNames, char** newColumnNames, int numChanges) {
    for (int i = 0; i < numChanges; i++) {
        for (int j = 0; j < df->numCols; j++) {
            if (strcmp(df->columnNames[j], oldColumnNames[i]) == 0) {
                free(df->columnNames[j]);
                df->columnNames[j] = strdup(newColumnNames[i]);
                break;
            }
        }
    }
    return df;
}