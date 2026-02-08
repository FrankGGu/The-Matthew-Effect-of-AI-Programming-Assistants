package main

func maxIncreaseKeepingSkyline(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }
    rows := make([]int, len(grid))
    cols := make([]int, len(grid[0]))
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] > rows[i] {
                rows[i] = grid[i][j]
            }
            if grid[i][j] > cols[j] {
                cols[j] = grid[i][j]
            }
        }
    }
    res := 0
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            res += min(rows[i], cols[j]) - grid[i][j]
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}