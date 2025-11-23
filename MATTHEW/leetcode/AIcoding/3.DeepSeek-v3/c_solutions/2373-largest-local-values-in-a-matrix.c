/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** largestLocal(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int n = gridSize;
    *returnSize = n - 2;
    *returnColumnSizes = malloc((n - 2) * sizeof(int));
    int** res = malloc((n - 2) * sizeof(int*));

    for (int i = 0; i < n - 2; i++) {
        (*returnColumnSizes)[i] = n - 2;
        res[i] = malloc((n - 2) * sizeof(int));
    }

    for (int i = 0; i < n - 2; i++) {
        for (int j = 0; j < n - 2; j++) {
            int max = grid[i][j];
            for (int x = i; x < i + 3; x++) {
                for (int y = j; y < j + 3; y++) {
                    if (grid[x][y] > max) {
                        max = grid[x][y];
                    }
                }
            }
            res[i][j] = max;
        }
    }

    return res;
}