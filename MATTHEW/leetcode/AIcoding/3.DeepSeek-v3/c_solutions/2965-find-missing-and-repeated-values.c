/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findMissingAndRepeatedValues(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int n = gridSize;
    int total = n * n;
    int* count = (int*)calloc(total + 1, sizeof(int));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            count[grid[i][j]]++;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 1; i <= total; i++) {
        if (count[i] == 2) {
            result[0] = i;
        } else if (count[i] == 0) {
            result[1] = i;
        }
    }

    free(count);
    return result;
}