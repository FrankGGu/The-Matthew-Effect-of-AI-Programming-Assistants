package main

func minDeletionSize(grid []string) int {
    n := len(grid)
    m := len(grid[0])
    count := 0
    for j := 0; j < m; j++ {
        for i := 1; i < n; i++ {
            if grid[i][j] < grid[i-1][j] {
                count++
                break
            }
        }
    }
    return count
}