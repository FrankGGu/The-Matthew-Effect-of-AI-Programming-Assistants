#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* data;
    int size;
} DataFrame;

DataFrame* dropDuplicateRows(DataFrame* df) {
    if (!df || df->size == 0) return NULL;

    int uniqueSize = 0;
    char** seen = (char**)malloc(df->size * sizeof(char*));
    for (int i = 0; i < df->size; i++) {
        seen[i] = NULL;
    }

    for (int i = 0; i < df->size; i++) {
        int isDuplicate = 0;
        for (int j = 0; j < uniqueSize; j++) {
            if (strcmp(df->data + i * (strlen(df->data) + 1), seen[j]) == 0) {
                isDuplicate = 1;
                break;
            }
        }
        if (!isDuplicate) {
            seen[uniqueSize++] = df->data + i * (strlen(df->data) + 1);
        }
    }

    char* resultData = (char*)malloc(uniqueSize * (strlen(df->data) + 1));
    for (int i = 0; i < uniqueSize; i++) {
        strcpy(resultData + i * (strlen(df->data) + 1), seen[i]);
    }

    DataFrame* result = (DataFrame*)malloc(sizeof(DataFrame));
    result->data = resultData;
    result->size = uniqueSize;

    for (int i = 0; i < df->size; i++) {
        free(seen[i]);
    }
    free(seen);

    return result;
}