#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** data;
    int rows;
    int cols;
} DataFrame;

int get_size(DataFrame* df) {
    return df->rows * df->cols;
}