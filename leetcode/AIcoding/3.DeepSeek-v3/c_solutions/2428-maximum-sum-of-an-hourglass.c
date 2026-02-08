int maxSum(int** grid, int gridSize, int* gridColSize) {
    int max = 0;
    for (int i = 0; i < gridSize - 2; i++) {
        for (int j = 0; j < *gridColSize - 2; j++) {
            int sum = grid[i][j] + grid[i][j+1] + grid[i][j+2] 
                    + grid[i+1][j+1] 
                    + grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2];
            if (sum > max || (i == 0 && j == 0)) {
                max = sum;
            }
        }
    }
    return max;
}