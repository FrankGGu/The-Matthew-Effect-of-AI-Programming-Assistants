bool findRotation(int** mat, int matSize, int* matColSize, int** target, int targetSize, int* targetColSize) {
    if (matSize != targetSize || *matColSize != *targetColSize) return false;

    for (int k = 0; k < 4; k++) {
        bool match = true;
        for (int i = 0; i < matSize; i++) {
            for (int j = 0; j < *matColSize; j++) {
                if (mat[i][j] != target[i][j]) {
                    match = false;
                    break;
                }
            }
            if (!match) break;
        }
        if (match) return true;

        int** newMat = (int**)malloc(matSize * sizeof(int*));
        for (int i = 0; i < matSize; i++) {
            newMat[i] = (int*)malloc(*matColSize * sizeof(int));
            for (int j = 0; j < *matColSize; j++) {
                newMat[i][j] = mat[matSize - j - 1][i];
            }
        }
        for (int i = 0; i < matSize; i++) {
            mat[i] = newMat[i];
        }
        free(newMat);
    }
    return false;
}