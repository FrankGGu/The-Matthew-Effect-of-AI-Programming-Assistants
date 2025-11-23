int kthLargestValue(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int n = matrixSize, m = *matrixColSize;
    int* prefix = (int*)malloc(n * m * sizeof(int));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (i == 0 && j == 0) {
                prefix[i * m + j] = matrix[i][j];
            } else if (i == 0) {
                prefix[i * m + j] = prefix[i * m + (j - 1)] ^ matrix[i][j];
            } else if (j == 0) {
                prefix[i * m + j] = prefix[(i - 1) * m + j] ^ matrix[i][j];
            } else {
                prefix[i * m + j] = prefix[(i - 1) * m + j] ^ prefix[i * m + (j - 1)] ^ prefix[(i - 1) * m + (j - 1)] ^ matrix[i][j];
            }
        }
    }

    int* arr = (int*)malloc(n * m * sizeof(int));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            arr[i * m + j] = prefix[i * m + j];
        }
    }

    free(prefix);

    qsort(arr, n * m, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int result = arr[n * m - k];
    free(arr);

    return result;
}