package main

func gridMaximumDifference(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])
    maxVal := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            maxVal = max(maxVal, grid[i][j])
        }
    }
    minVal := 1000000
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            minVal = min(minVal, grid[i][j])
        }
    }
    return maxVal - minVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}