int countEqualSubmatrices(int** matrix, int matrixSize, int* matrixColSize, int x, int y) {
    int count = 0;
    int rows = matrixSize;
    int cols = *matrixColSize;
    int** freq = (int**)malloc((rows + 1) * sizeof(int*));
    for (int i = 0; i <= rows; i++) {
        freq[i] = (int*)malloc((cols + 1) * sizeof(int));
        memset(freq[i], 0, (cols + 1) * sizeof(int));
    }

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            freq[i][j] = freq[i - 1][j] + freq[i][j - 1] - freq[i - 1][j - 1] + (matrix[i - 1][j - 1] == x);
        }
    }

    for (int r1 = 0; r1 < rows; r1++) {
        for (int r2 = r1; r2 < rows; r2++) {
            for (int c1 = 0; c1 < cols; c1++) {
                for (int c2 = c1; c2 < cols; c2++) {
                    int countX = freq[r2 + 1][c2 + 1] - freq[r1][c2 + 1] - freq[r2 + 1][c1] + freq[r1][c1];
                    int countY = (r2 - r1 + 1) * (c2 - c1 + 1) - countX;
                    if (countX == countY) {
                        count++;
                    }
                }
            }
        }
    }

    for (int i = 0; i <= rows; i++) {
        free(freq[i]);
    }
    free(freq);
    return count;
}