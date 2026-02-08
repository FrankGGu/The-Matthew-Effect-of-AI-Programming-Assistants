/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findDiagonalOrder(int** mat, int matSize, int* matColSize, int* returnSize) {
    if (matSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int m = matSize;
    int n = matColSize[0];
    *returnSize = m * n;
    int* result = (int*)malloc(*returnSize * sizeof(int));

    int row = 0, col = 0;
    int direction = 1;

    for (int i = 0; i < *returnSize; i++) {
        result[i] = mat[row][col];

        if (direction == 1) {
            if (col == n - 1) {
                row++;
                direction = -1;
            } else if (row == 0) {
                col++;
                direction = -1;
            } else {
                row--;
                col++;
            }
        } else {
            if (row == m - 1) {
                col++;
                direction = 1;
            } else if (col == 0) {
                row++;
                direction = 1;
            } else {
                row++;
                col--;
            }
        }
    }

    return result;
}