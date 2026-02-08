int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int deleteGreatestValue(int** grid, int gridSize, int* gridColSize) {
    for (int i = 0; i < gridSize; i++) {
        qsort(grid[i], gridColSize[i], sizeof(int), cmp);
    }

    int res = 0;
    for (int j = 0; j < gridColSize[0]; j++) {
        int maxVal = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] > maxVal) {
                maxVal = grid[i][j];
            }
        }
        res += maxVal;
    }

    return res;
}