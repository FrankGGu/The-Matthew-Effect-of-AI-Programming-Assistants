int numSubmatrixSumTarget(int** matrix, int matrixSize, int* matrixColSize, int target) {
    int m = matrixSize;
    int n = matrixColSize[0];

    // Compute prefix sums for each row
    for (int i = 0; i < m; i++) {
        for (int j = 1; j < n; j++) {
            matrix[i][j] += matrix[i][j-1];
        }
    }

    int count = 0;

    // For each pair of columns
    for (int c1 = 0; c1 < n; c1++) {
        for (int c2 = c1; c2 < n; c2++) {
            // Use hash map to count prefix sums
            int* map = (int*)calloc(20001, sizeof(int));
            map[10000] = 1; // For sum = 0

            int sum = 0;
            for (int r = 0; r < m; r++) {
                // Calculate sum for current submatrix [r, c1] to [r, c2]
                int rowSum = matrix[r][c2];
                if (c1 > 0) {
                    rowSum -= matrix[r][c1-1];
                }
                sum += rowSum;

                // Check if (sum - target) exists in map
                int key = sum - target + 10000;
                if (key >= 0 && key < 20001) {
                    count += map[key];
                }

                // Update map
                map[sum + 10000]++;
            }
            free(map);
        }
    }

    return count;
}