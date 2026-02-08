bool areSimilar(int** mat, int matSize, int* matColSize, int k) {
    int n = matSize;
    int m = matColSize[0];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int expected = mat[i][(j + k) % m];
            if (mat[i][j] != expected) {
                return false;
            }
        }
    }
    return true;
}