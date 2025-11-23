long long maxMatrixSum(int** matrix, int matrixSize, int* matrixColSize){
    long long sum = 0;
    int min_abs = INT_MAX;
    int negative_count = 0;

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
            int val = matrix[i][j];
            sum += abs(val);
            if (val < 0) {
                negative_count++;
            }
            if (abs(val) < min_abs) {
                min_abs = abs(val);
            }
        }
    }

    if (negative_count % 2 == 0) {
        return sum;
    } else {
        return sum - 2 * min_abs;
    }
}