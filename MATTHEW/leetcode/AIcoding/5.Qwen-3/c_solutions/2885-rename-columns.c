#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** data;
    int size;
} DataFrame;

DataFrame* renameColumns(DataFrame* df, char** newNames, int newNamesSize) {
    DataFrame* result = (DataFrame*)malloc(sizeof(DataFrame));
    result->size = df->size;
    result->data = (char**)malloc(df->size * sizeof(char*));

    for (int i = 0; i < df->size; i++) {
        result->data[i] = strdup(df->data[i]);
    }

    return result;
}