#define MAXN 50
#define MAX_SUMS 3

int getRhombusSum(int** grid, int r, int c, int size, int n, int m) {
    int sum = 0;
    for (int i = 0; i <= size; i++) {
        sum += grid[r + i][c] + grid[r + size - i][c];
    }
    sum -= grid[r][c] + grid[r + size][c]; // remove double count of the middle
    return sum;
}

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int* getBiggestThree(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int maxSize = (gridSize < *gridColSize ? gridSize : *gridColSize);
    int sums[MAXN * MAXN] = {0};
    int cnt = 0;

    for (int r = 0; r < gridSize; r++) {
        for (int c = 0; c < *gridColSize; c++) {
            for (int size = 0; r + size < gridSize && c - size >= 0 && c + size < *gridColSize; size++) {
                int rhombusSum = getRhombusSum(grid, r, c, size, gridSize, *gridColSize);
                sums[cnt++] = rhombusSum;
            }
        }
    }

    qsort(sums, cnt, sizeof(int), compare);
    int* result = (int*)malloc(MAX_SUMS * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < cnt && *returnSize < MAX_SUMS; i++) {
        if (i == 0 || sums[i] != sums[i - 1]) {
            result[(*returnSize)++] = sums[i];
        }
    }

    return result;
}