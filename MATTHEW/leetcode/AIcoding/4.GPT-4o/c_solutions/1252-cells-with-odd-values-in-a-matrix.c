int oddCells(int rows, int cols, int** indices, int indicesSize, int* indicesColSize) {
    int rowCount[rows];
    int colCount[cols];
    int count = 0;

    for (int i = 0; i < rows; i++) {
        rowCount[i] = 0;
    }
    for (int i = 0; i < cols; i++) {
        colCount[i] = 0;
    }

    for (int i = 0; i < indicesSize; i++) {
        rowCount[indices[i][0]]++;
        colCount[indices[i][1]]++;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if ((rowCount[i] + colCount[j]) % 2 != 0) {
                count++;
            }
        }
    }

    return count;
}