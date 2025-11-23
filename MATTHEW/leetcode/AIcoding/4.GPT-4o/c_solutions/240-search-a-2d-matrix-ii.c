bool searchMatrix(int** matrix, int matrixSize, int* matrixColSize, int target) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return false;

    int row = matrixSize - 1;
    int col = 0;

    while (row >= 0 && col < matrixColSize[0]) {
        if (matrix[row][col] == target) {
            return true;
        } else if (matrix[row][col] > target) {
            row--;
        } else {
            col++;
        }
    }

    return false;
}