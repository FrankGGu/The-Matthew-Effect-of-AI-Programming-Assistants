typedef struct {
    int rows;
    int cols;
} DataFrame;

DataFrame* createDataFrame(int rows, int cols) {
    DataFrame* df = (DataFrame*)malloc(sizeof(DataFrame));
    df->rows = rows;
    df->cols = cols;
    return df;
}

int getRowCount(DataFrame* df) {
    return df->rows;
}

int getColCount(DataFrame* df) {
    return df->cols;
}

void freeDataFrame(DataFrame* df) {
    free(df);
}