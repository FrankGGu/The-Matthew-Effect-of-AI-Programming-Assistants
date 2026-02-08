#include <stdlib.h>

typedef struct {
    char **first_name;
    char **last_name;
    int *age;
    int personCount;
} DataFrame;

DataFrame* createDataFrame(char **first_name, int first_nameSize, char **last_name, int last_nameSize, int *age, int ageSize) {
    DataFrame *df = (DataFrame*)malloc(sizeof(DataFrame));
    df->first_name = first_name;
    df->last_name = last_name;
    df->age = age;
    df->personCount = first_nameSize;
    return df;
}

void freeDataFrame(DataFrame* df) {
    free(df);
}