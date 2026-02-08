#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;

    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int dp[matrixSize][*matrixColSize];
    memset(dp, 0, sizeof(dp));

    int longestPath = 0;

    void dfs(int x, int y, int rows, int cols) {
        if (dp[x][y] != 0) return;

        dp[x][y] = 1;

        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && matrix[newX][newY] > matrix[x][y]) {
                dfs(newX, newY, rows, cols);
                dp[x][y] = MAX(dp[x][y], dp[newX][newY] + 1);
            }
        }
    }

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            if (dp[i][j] == 0) {
                dfs(i, j, matrixSize, *matrixColSize);
            }
            longestPath = MAX(longestPath, dp[i][j]);
        }
    }

    return longestPath;
}