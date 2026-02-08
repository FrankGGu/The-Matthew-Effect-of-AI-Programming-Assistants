#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char* name;
} DataFrame;

DataFrame* createDataFrame(int* ids, char** names, int size) {
    DataFrame* df = (DataFrame*)malloc(sizeof(DataFrame) * size);
    if (df == NULL) {
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        df[i].id = ids[i];
        df[i].name = (char*)malloc(strlen(names[i]) + 1);
        if (df[i].name == NULL) {
            for (int j = 0; j < i; j++) {
                free(df[j].name);
            }
            free(df);
            return NULL;
        }
        strcpy(df[i].name, names[i]);
    }

    return df;
}