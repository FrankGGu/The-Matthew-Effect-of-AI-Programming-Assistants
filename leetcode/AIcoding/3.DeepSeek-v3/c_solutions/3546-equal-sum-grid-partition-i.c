int** partitionGrid(int n, int* grid, int gridSize, int* returnSize, int** returnColumnSizes) {
    int total = 0;
    for (int i = 0; i < gridSize; i++) {
        total += grid[i];
    }

    int target = total / 2;
    int** result = (int**)malloc(2 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int* first = (int*)malloc(n * n / 2 * sizeof(int));
    int* second = (int*)malloc(n * n / 2 * sizeof(int));
    int idx1 = 0, idx2 = 0;

    int sum1 = 0;
    for (int i = 0; i < gridSize; i++) {
        if (sum1 + grid[i] <= target) {
            first[idx1++] = grid[i];
            sum1 += grid[i];
        } else {
            second[idx2++] = grid[i];
        }
    }

    result[0] = first;
    result[1] = second;
    (*returnColumnSizes)[0] = idx1;
    (*returnColumnSizes)[1] = idx2;

    return result;
}