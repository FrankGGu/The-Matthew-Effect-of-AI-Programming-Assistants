/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findBall(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    for (int ball = 0; ball < n; ball++) {
        int col = ball;
        for (int row = 0; row < m; row++) {
            int direction = grid[row][col];
            if (direction == 1) {
                if (col == n - 1 || grid[row][col + 1] == -1) {
                    col = -1;
                    break;
                }
                col++;
            } else {
                if (col == 0 || grid[row][col - 1] == 1) {
                    col = -1;
                    break;
                }
                col--;
            }
        }
        result[ball] = col;
    }

    return result;
}