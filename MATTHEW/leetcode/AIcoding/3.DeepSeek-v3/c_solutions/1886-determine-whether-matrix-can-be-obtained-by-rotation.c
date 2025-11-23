bool findRotation(int** mat, int matSize, int* matColSize, int** target, int targetSize, int* targetColSize) {
    bool c0 = true, c90 = true, c180 = true, c270 = true;
    int n = matSize;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] != target[i][j]) c0 = false;
            if (mat[i][j] != target[j][n - 1 - i]) c90 = false;
            if (mat[i][j] != target[n - 1 - i][n - 1 - j]) c180 = false;
            if (mat[i][j] != target[n - 1 - j][i]) c270 = false;
        }
    }

    return c0 || c90 || c180 || c270;
}