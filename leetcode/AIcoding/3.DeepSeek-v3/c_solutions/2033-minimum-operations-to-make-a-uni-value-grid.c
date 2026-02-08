int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minOperations(int** grid, int gridSize, int* gridColSize, int x) {
    int m = gridSize;
    int n = gridColSize[0];
    int total = m * n;
    int* arr = (int*)malloc(total * sizeof(int));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            arr[i * n + j] = grid[i][j];
        }
    }

    qsort(arr, total, sizeof(int), cmp);

    int median = arr[total / 2];
    int operations = 0;

    for (int i = 0; i < total; i++) {
        int diff = abs(arr[i] - median);
        if (diff % x != 0) {
            free(arr);
            return -1;
        }
        operations += diff / x;
    }

    free(arr);
    return operations;
}