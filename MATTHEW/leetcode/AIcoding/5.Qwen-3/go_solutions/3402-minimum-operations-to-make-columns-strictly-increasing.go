package main

func minOperations(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    operations := 0

    for j := 0; j < cols; j++ {
        for i := 1; i < rows; i++ {
            if grid[i][j] <= grid[i-1][j] {
                operations += grid[i-1][j] - grid[i][j] + 1
                grid[i][j] += grid[i-1][j] - grid[i][j] + 1
            }
        }
    }

    return operations
}