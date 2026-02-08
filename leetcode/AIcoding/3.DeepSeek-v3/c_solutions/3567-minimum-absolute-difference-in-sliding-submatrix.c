/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored in *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** minDifference(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];
    int k = 2;

    *returnSize = m - k + 1;
    *returnColumnSizes = malloc((*returnSize) * sizeof(int));
    int** res = malloc((*returnSize) * sizeof(int*));

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = n - k + 1;
        res[i] = malloc((n - k + 1) * sizeof(int));
    }

    for (int i = 0; i <= m - k; i++) {
        for (int j = 0; j <= n - k; j++) {
            int minDiff = INT_MAX;
            int minVal = INT_MAX;
            int maxVal = INT_MIN;

            for (int x = i; x < i + k; x++) {
                for (int y = j; y < j + k; y++) {
                    if (grid[x][y] < minVal) minVal = grid[x][y];
                    if (grid[x][y] > maxVal) maxVal = grid[x][y];
                }
            }

            res[i][j] = maxVal - minVal;
        }
    }

    return res;
}