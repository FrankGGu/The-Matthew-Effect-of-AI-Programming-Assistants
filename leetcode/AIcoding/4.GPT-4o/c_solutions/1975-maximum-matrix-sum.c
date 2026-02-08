int maxMatrixSum(int** matrix, int matrixSize, int* matrixColSize){
    long long sum = 0, minAbs = LONG_MAX;
    int negativeCount = 0;

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[i]; j++) {
            if (matrix[i][j] < 0) {
                negativeCount++;
            }
            sum += abs(matrix[i][j]);
            if (abs(matrix[i][j]) < minAbs) {
                minAbs = abs(matrix[i][j]);
            }
        }
    }

    if (negativeCount % 2 == 0) {
        return sum;
    } else {
        return sum - 2 * minAbs;
    }
}