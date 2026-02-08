int* luckyNumbers (int** matrix, int matrixSize, int* matrixColSize, int* returnSize){
    int m = matrixSize;
    int n = matrixColSize[0];
    int* rowMin = (int*)malloc(m * sizeof(int));
    int* colMax = (int*)malloc(n * sizeof(int));

    for(int i = 0; i < m; i++) {
        rowMin[i] = matrix[i][0];
        for(int j = 1; j < n; j++) {
            if(matrix[i][j] < rowMin[i]) {
                rowMin[i] = matrix[i][j];
            }
        }
    }

    for(int j = 0; j < n; j++) {
        colMax[j] = matrix[0][j];
        for(int i = 1; i < m; i++) {
            if(matrix[i][j] > colMax[j]) {
                colMax[j] = matrix[i][j];
            }
        }
    }

    int* result = (int*)malloc(m * n * sizeof(int));
    int count = 0;

    for(int i = 0; i < m; i++) {
        for(int j = 0; j < n; j++) {
            if(matrix[i][j] == rowMin[i] && matrix[i][j] == colMax[j]) {
                result[count++] = matrix[i][j];
            }
        }
    }

    free(rowMin);
    free(colMax);
    *returnSize = count;
    return result;
}