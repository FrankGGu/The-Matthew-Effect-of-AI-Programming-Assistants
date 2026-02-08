#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** names;
    int* ages;
    int size;
} DataFrame;

DataFrame* createDataFrame(char** names, int namesSize, int* ages, int agesSize) {
    DataFrame* df = (DataFrame*)malloc(sizeof(DataFrame));
    df->size = namesSize;
    df->names = (char**)malloc(namesSize * sizeof(char*));
    df->ages = (int*)malloc(namesSize * sizeof(int));
    for (int i = 0; i < namesSize; i++) {
        df->names[i] = strdup(names[i]);
        df->ages[i] = ages[i];
    }
    return df;
}