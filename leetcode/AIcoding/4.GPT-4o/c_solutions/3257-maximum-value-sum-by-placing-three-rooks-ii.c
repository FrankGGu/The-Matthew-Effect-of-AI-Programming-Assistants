int maxSum(int** grid, int gridSize, int* gridColSize) {
    int maxSum = 0;
    for (int i = 0; i < gridSize - 2; i++) {
        for (int j = 0; j < gridColSize[0] - 2; j++) {
            for (int k = i + 1; k < gridSize - 1; k++) {
                for (int l = j + 1; l < gridColSize[0] - 1; l++) {
                    for (int m = k + 1; m < gridSize; m++) {
                        int currentSum = 0;
                        currentSum += grid[i][j] + grid[i][l] + grid[i + 1][j] + grid[i + 1][l] + 
                                      grid[k][j] + grid[k][l] + grid[k + 1][j] + grid[k + 1][l] + 
                                      grid[m][j] + grid[m][l] + grid[m][j + 1] + grid[m][l + 1];
                        maxSum = currentSum > maxSum ? currentSum : maxSum;
                    }
                }
            }
        }
    }
    return maxSum;
}