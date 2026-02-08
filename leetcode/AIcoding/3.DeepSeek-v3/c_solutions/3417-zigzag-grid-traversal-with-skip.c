/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* zigzagTraversal(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];
    *returnSize = m * n - (m * n) / 2;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    int idx = 0;

    for (int i = 0; i < m; i++) {
        if (i % 2 == 0) {
            for (int j = 0; j < n; j += 2) {
                result[idx++] = grid[i][j];
            }
        } else {
            for (int j = n - 1 - (n % 2); j >= 0; j -= 2) {
                result[idx++] = grid[i][j];
            }
        }
    }

    return result;
}