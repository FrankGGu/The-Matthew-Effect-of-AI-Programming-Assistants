package main

func countServers(grid [][]int) int {
    rows := make([]int, len(grid))
    cols := make([]int, len(grid[0]))

    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 1 {
                rows[i]++
                cols[j]++
            }
        }
    }

    count := 0
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 1 && (rows[i] > 1 || cols[j] > 1) {
                count++
            }
        }
    }

    return count
}