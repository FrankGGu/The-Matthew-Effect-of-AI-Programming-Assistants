int numSubmatrixSumTarget(int** matrix, int matrixSize, int* matrixColSize, int target) {
    int rows = matrixSize, cols = *matrixColSize;
    int count = 0;

    for (int left = 0; left < cols; left++) {
        int* sums = (int*)calloc(rows, sizeof(int));

        for (int right = left; right < cols; right++) {
            for (int i = 0; i < rows; i++) {
                sums[i] += matrix[i][right];
            }

            // Count subarrays that sum to target using hash map
            int currentSum = 0;
            int* hashMap = (int*)calloc(rows * cols + 1, sizeof(int));
            hashMap[0] = 1; // to handle the case where sum equals target

            for (int i = 0; i < rows; i++) {
                currentSum += sums[i];
                if (currentSum - target >= 0) {
                    count += hashMap[currentSum - target];
                }
                hashMap[currentSum]++;
            }

            free(hashMap);
        }

        free(sums);
    }

    return count;
}