int** matrixRankTransform(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int row = matrixSize, col = *matrixColSize;
    int* rank = (int*)calloc(row * col, sizeof(int));
    int** result = (int**)malloc(row * sizeof(int*));
    for (int i = 0; i < row; i++) {
        result[i] = (int*)malloc(col * sizeof(int));
    }

    int** sorted = (int**)malloc(row * col * sizeof(int*));
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            sorted[i * col + j] = (int*)malloc(3 * sizeof(int));
            sorted[i * col + j][0] = matrix[i][j];
            sorted[i * col + j][1] = i;
            sorted[i * col + j][2] = j;
        }
    }

    qsort(sorted, row * col, sizeof(int*), [](const void* a, const void* b) {
        return (*(int**)a)[0] - (*(int**)b)[0];
    });

    int* rowRank = (int*)calloc(row, sizeof(int));
    int* colRank = (int*)calloc(col, sizeof(int));

    for (int i = 0; i < row * col; i++) {
        int r = sorted[i][1];
        int c = sorted[i][2];
        int currRank = 1;

        if (i > 0 && sorted[i][0] == sorted[i - 1][0]) {
            currRank = rank[r * col + c];
        }

        rowRank[r] = currRank;
        colRank[c] = currRank;

        for (int j = 0; j < row; j++) {
            if (rowRank[j] > currRank) {
                currRank = rowRank[j];
            }
        }
        for (int j = 0; j < col; j++) {
            if (colRank[j] > currRank) {
                currRank = colRank[j];
            }
        }

        rank[r * col + c] = currRank;
        result[r][c] = currRank;
    }

    free(rowRank);
    free(colRank);
    for (int i = 0; i < row * col; i++) {
        free(sorted[i]);
    }
    free(sorted);

    *returnSize = row;
    *returnColumnSizes = (int*)malloc(row * sizeof(int));
    for (int i = 0; i < row; i++) {
        (*returnColumnSizes)[i] = col;
    }

    return result;
}