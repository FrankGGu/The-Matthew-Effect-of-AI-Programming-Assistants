bool checkValid(int** matrix, int matrixSize, int* matrixColSize) {
    int n = matrixSize;
    int row[9], col[9];

    for (int i = 0; i < n; i++) {
        memset(row, 0, sizeof(row));
        memset(col, 0, sizeof(col));
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] != 0) {
                if (row[matrix[i][j] - 1]++) return false;
            }
            if (matrix[j][i] != 0) {
                if (col[matrix[j][i] - 1]++) return false;
            }
        }
    }
    return true;
}