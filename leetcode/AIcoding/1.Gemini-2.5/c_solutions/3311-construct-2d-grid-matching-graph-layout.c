int** construct2DArray(int* nums, int numsSize, int m, int n, int* returnSize, int** returnColumnSizes) {
    if (numsSize != m * n) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int** grid = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        grid[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            grid[i][j] = nums[i * n + j];
        }
    }

    return grid;
}