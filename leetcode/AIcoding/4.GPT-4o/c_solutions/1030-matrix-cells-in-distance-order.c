int** allCellsDistOrder(int rows, int cols, int rCenter, int cCenter, int* returnSize, int** returnColumnSizes) {
    int totalCells = rows * cols;
    int** result = (int**)malloc(totalCells * sizeof(int*));
    int* distances = (int*)malloc(totalCells * sizeof(int));
    int index = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = r;
            result[index][1] = c;
            distances[index] = abs(r - rCenter) + abs(c - cCenter);
            index++;
        }
    }

    for (int i = 0; i < totalCells - 1; i++) {
        for (int j = 0; j < totalCells - i - 1; j++) {
            if (distances[j] > distances[j + 1]) {
                int* tempCell = result[j];
                result[j] = result[j + 1];
                result[j + 1] = tempCell;

                int tempDist = distances[j];
                distances[j] = distances[j + 1];
                distances[j + 1] = tempDist;
            }
        }
    }

    *returnSize = totalCells;
    *returnColumnSizes = (int*)malloc(totalCells * sizeof(int));
    for (int i = 0; i < totalCells; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    free(distances);
    return result;
}