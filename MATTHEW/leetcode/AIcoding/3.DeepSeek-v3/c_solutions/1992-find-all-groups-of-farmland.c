/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** findFarmland(int** land, int landSize, int* landColSize, int* returnSize, int** returnColumnSizes) {
    int m = landSize;
    int n = landColSize[0];

    int** result = malloc(m * n * sizeof(int*));
    *returnColumnSizes = malloc(m * n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (land[i][j] == 1) {
                int r2 = i, c2 = j;

                while (r2 < m && land[r2][j] == 1) r2++;
                while (c2 < n && land[i][c2] == 1) c2++;

                r2--;
                c2--;

                for (int r = i; r <= r2; r++) {
                    for (int c = j; c <= c2; c++) {
                        land[r][c] = 0;
                    }
                }

                result[*returnSize] = malloc(4 * sizeof(int));
                result[*returnSize][0] = i;
                result[*returnSize][1] = j;
                result[*returnSize][2] = r2;
                result[*returnSize][3] = c2;
                (*returnColumnSizes)[*returnSize] = 4;
                (*returnSize)++;
            }
        }
    }

    return result;
}