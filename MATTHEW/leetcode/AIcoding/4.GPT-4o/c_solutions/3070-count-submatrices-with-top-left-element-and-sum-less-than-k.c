int countSubmatricesWithSumLessThanK(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int count = 0;
    int rows = matrixSize;
    int cols = *matrixColSize;
    int* sums = (int*)malloc(cols * sizeof(int));

    for (int top = 0; top < rows; top++) {
        memset(sums, 0, cols * sizeof(int));
        for (int bottom = top; bottom < rows; bottom++) {
            for (int j = 0; j < cols; j++) {
                sums[j] += matrix[bottom][j];
            }
            for (int left = 0; left < cols; left++) {
                int total = 0;
                for (int right = left; right < cols; right++) {
                    total += sums[right];
                    if (total < k) {
                        count++;
                    } else {
                        break;
                    }
                }
            }
        }
    }

    free(sums);
    return count;
}