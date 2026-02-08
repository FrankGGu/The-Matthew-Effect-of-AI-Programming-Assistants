/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** rotateGrid(int** grid, int gridSize, int* gridColSize, int k, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int** result = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            result[i][j] = grid[i][j];
        }
    }

    int layers = (m < n ? m : n) / 2;

    for (int layer = 0; layer < layers; layer++) {
        int top = layer;
        int bottom = m - 1 - layer;
        int left = layer;
        int right = n - 1 - layer;

        int perimeter = 2 * (bottom - top + 1) + 2 * (right - left + 1) - 4;
        int effective_k = k % perimeter;

        if (effective_k == 0) continue;

        int* temp = (int*)malloc(perimeter * sizeof(int));
        int idx = 0;

        for (int i = top; i <= bottom; i++) temp[idx++] = grid[i][left];
        for (int j = left + 1; j <= right; j++) temp[idx++] = grid[bottom][j];
        for (int i = bottom - 1; i >= top; i--) temp[idx++] = grid[i][right];
        for (int j = right - 1; j > left; j--) temp[idx++] = grid[top][j];

        idx = effective_k;
        for (int i = top; i <= bottom; i++) result[i][left] = temp[idx++ % perimeter];
        for (int j = left + 1; j <= right; j++) result[bottom][j] = temp[idx++ % perimeter];
        for (int i = bottom - 1; i >= top; i--) result[i][right] = temp[idx++ % perimeter];
        for (int j = right - 1; j > left; j--) result[top][j] = temp[idx++ % perimeter];

        free(temp);
    }

    return result;
}