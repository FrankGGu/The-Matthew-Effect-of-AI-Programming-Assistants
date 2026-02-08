char **reshapeData(char **data, int dataSize, int *dataColSize, int *returnSize, int **returnColumnSizes) {
    int totalElements = 0;
    for (int i = 0; i < dataSize; i++) {
        totalElements += dataColSize[i];
    }

    if (totalElements == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int newRows = totalElements / 2;
    int newCols = 2;

    if (totalElements % 2 != 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    char **reshapedData = (char **)malloc(newRows * sizeof(char *));
    *returnColumnSizes = (int *)malloc(newRows * sizeof(int));

    for (int i = 0; i < newRows; i++) {
        reshapedData[i] = (char *)malloc(newCols * sizeof(char));
        (*returnColumnSizes)[i] = newCols;
        for (int j = 0; j < newCols; j++) {
            int index = i * newCols + j;
            reshapedData[i][j] = data[index / dataColSize[index / dataColSize[0]]][index % dataColSize[index / dataColSize[0]]];
        }
    }

    *returnSize = newRows;
    return reshapedData;
}