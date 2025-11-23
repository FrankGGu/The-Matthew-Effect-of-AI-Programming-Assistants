int** buildMatrix(int k, int** rowConditions, int rowSize, int* colSizes, int* returnSize, int** colConditions, int colSize, int* colCondSizes) {
    int* rowIndegree = (int*)calloc(k + 1, sizeof(int));
    int* colIndegree = (int*)calloc(k + 1, sizeof(int));
    int** rowGraph = (int**)malloc((k + 1) * sizeof(int*));
    int** colGraph = (int**)malloc((k + 1) * sizeof(int*));
    for (int i = 1; i <= k; i++) {
        rowGraph[i] = (int*)malloc((k + 1) * sizeof(int));
        colGraph[i] = (int*)malloc((k + 1) * sizeof(int));
        memset(rowGraph[i], 0, sizeof(int) * (k + 1));
        memset(colGraph[i], 0, sizeof(int) * (k + 1));
    }

    for (int i = 0; i < rowSize; i++) {
        int u = rowConditions[i][0], v = rowConditions[i][1];
        rowGraph[u][v] = 1;
        rowIndegree[v]++;
    }

    for (int i = 0; i < colSize; i++) {
        int u = colConditions[i][0], v = colConditions[i][1];
        colGraph[u][v] = 1;
        colIndegree[v]++;
    }

    int* rowOrder = (int*)malloc((k + 1) * sizeof(int));
    int* colOrder = (int*)malloc((k + 1) * sizeof(int));
    int rowCount = 0, colCount = 0;

    for (int i = 1; i <= k; i++) {
        for (int j = 1; j <= k; j++) {
            if (rowIndegree[j] == 0 && rowGraph[i][j]) {
                rowOrder[rowCount++] = j;
                rowIndegree[j]--;
                for (int m = 1; m <= k; m++) {
                    if (rowGraph[j][m]) rowIndegree[m]--;
                }
            }
            if (colIndegree[j] == 0 && colGraph[i][j]) {
                colOrder[colCount++] = j;
                colIndegree[j]--;
                for (int m = 1; m <= k; m++) {
                    if (colGraph[j][m]) colIndegree[m]--;
                }
            }
        }
    }

    if (rowCount < k || colCount < k) {
        free(rowIndegree);
        free(colIndegree);
        return NULL;
    }

    int** matrix = (int**)malloc(k * sizeof(int*));
    for (int i = 0; i < k; i++) {
        matrix[i] = (int*)malloc(k * sizeof(int));
        for (int j = 0; j < k; j++) {
            matrix[i][j] = 0;
        }
    }

    for (int i = 0; i < k; i++) {
        matrix[i][colOrder[i] - 1] = i + 1;
        matrix[rowOrder[i] - 1][i] = i + 1;
    }

    *returnSize = k;
    free(rowIndegree);
    free(colIndegree);
    free(rowOrder);
    free(colOrder);
    for (int i = 1; i <= k; i++) {
        free(rowGraph[i]);
        free(colGraph[i]);
    }
    free(rowGraph);
    free(colGraph);

    return matrix;
}