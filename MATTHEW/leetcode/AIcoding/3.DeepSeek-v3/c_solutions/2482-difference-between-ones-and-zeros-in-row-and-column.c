/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored in *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** onesMinusZeros(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    int* onesRow = (int*)calloc(m, sizeof(int));
    int* onesCol = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                onesRow[i]++;
                onesCol[j]++;
            }
        }
    }

    int** diff = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        diff[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - m - n;
        }
    }

    free(onesRow);
    free(onesCol);

    return diff;
}