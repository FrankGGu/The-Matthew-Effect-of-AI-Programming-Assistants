typedef struct {
    char** column1;
    char** column2;
    int size;
} DataFrame;

DataFrame* createDataFrame(char** column1, char** column2, int size) {
    DataFrame* df = malloc(sizeof(DataFrame));
    df->column1 = malloc(size * sizeof(char*));
    df->column2 = malloc(size * sizeof(char*));

    for (int i = 0; i < size; i++) {
        df->column1[i] = strdup(column1[i]);
        df->column2[i] = strdup(column2[i]);
    }

    df->size = size;
    return df;
}

void freeDataFrame(DataFrame* df) {
    for (int i = 0; i < df->size; i++) {
        free(df->column1[i]);
        free(df->column2[i]);
    }
    free(df->column1);
    free(df->column2);
    free(df);
}