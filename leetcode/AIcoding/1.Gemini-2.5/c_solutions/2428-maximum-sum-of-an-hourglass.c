int maxSum(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int max_hourglass_sum = 0;

    for (int r = 0; r <= m - 3; r++) {
        for (int c = 0; c <= n - 3; c++) {
            int current_hourglass_sum = 
                grid[r][c] + grid[r][c+1] + grid[r][c+2] +
                grid[r+1][c+1] +
                grid[r+2][c] + grid[r+2][c+1] + grid[r+2][c+2];

            if (current_hourglass_sum > max_hourglass_sum) {
                max_hourglass_sum = current_hourglass_sum;
            }
        }
    }

    return max_hourglass_sum;
}