int kthSmallest(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int low = matrix[0][0];
    int high = matrix[matrixSize - 1][matrixSize - 1];

    while (low < high) {
        int mid = low + (high - low) / 2;
        int count = 0;
        int j = matrixSize - 1;

        for (int i = 0; i < matrixSize; i++) {
            while (j >= 0 && matrix[i][j] > mid) {
                j--;
            }
            count += (j + 1);
        }

        if (count < k) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    return low;
}