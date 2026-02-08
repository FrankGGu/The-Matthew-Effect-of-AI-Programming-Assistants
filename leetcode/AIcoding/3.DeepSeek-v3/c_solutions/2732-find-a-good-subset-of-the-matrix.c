int* goodSubset(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int n = matrixSize;
    int m = *matrixColSize;

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        int allZero = 1;
        for (int j = 0; j < m; j++) {
            if (matrix[i][j] != 0) {
                allZero = 0;
                break;
            }
        }
        if (allZero) {
            result[0] = i;
            *returnSize = 1;
            return result;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int valid = 1;
            for (int k = 0; k < m; k++) {
                if (matrix[i][k] == 1 && matrix[j][k] == 1) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                result[0] = i;
                result[1] = j;
                *returnSize = 2;
                return result;
            }
        }
    }

    return result;
}