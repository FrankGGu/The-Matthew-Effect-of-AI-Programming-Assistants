typedef struct {
    int col;
    int *row;
} Row;

Row* reshapeData(int** data, int dataSize, int* dataColSize, int* returnSize, int** returnColumnSizes) {
    int totalRows = 0;
    for (int i = 0; i < dataSize; i++) {
        totalRows += dataColSize[i];
    }

    Row* reshaped = (Row*)malloc(totalRows * sizeof(Row));
    *returnColumnSizes = (int*)malloc(totalRows * sizeof(int));
    *returnSize = totalRows;

    int index = 0;
    for (int i = 0; i < dataSize; i++) {
        for (int j = 0; j < dataColSize[i]; j++) {
            reshaped[index].col = 1;
            reshaped[index].row = (int*)malloc(sizeof(int));
            reshaped[index].row[0] = data[i][j];
            (*returnColumnSizes)[index] = 1;
            index++;
        }
    }

    return reshaped;
}