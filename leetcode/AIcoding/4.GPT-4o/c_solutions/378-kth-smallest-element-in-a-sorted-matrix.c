int kthSmallest(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int left = matrix[0][0], right = matrix[matrixSize - 1][matrixColSize[0] - 1];

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = 0, j = matrixColSize[0] - 1;

        for (int i = 0; i < matrixSize; i++) {
            while (j >= 0 && matrix[i][j] > mid) {
                j--;
            }
            count += (j + 1);
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}