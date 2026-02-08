int* findPeakGrid(int** mat, int matSize, int* matColSize) {
    int left = 0, right = matColSize[0] - 1;

    while (left < right) {
        int mid = left + (right - left) / 2;
        int maxRow = 0;

        for (int i = 0; i < matSize; i++) {
            if (mat[i][mid] > mat[maxRow][mid]) {
                maxRow = i;
            }
        }

        if (mid < right && mat[maxRow][mid] < mat[maxRow][mid + 1]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    int maxRow = 0;

    for (int i = 0; i < matSize; i++) {
        if (mat[i][left] > mat[maxRow][left]) {
            maxRow = i;
        }
    }

    result[0] = maxRow;
    result[1] = left;
    return result;
}