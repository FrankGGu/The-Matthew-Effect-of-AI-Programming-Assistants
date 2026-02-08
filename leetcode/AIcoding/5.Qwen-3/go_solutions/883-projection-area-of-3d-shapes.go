package main

func projectionArea(grid [][]int) int {
    n := len(grid)
    xy := 0
    xz := 0
    yz := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] > 0 {
                xy++
            }
        }
    }
    for i := 0; i < n; i++ {
        maxRow := 0
        for j := 0; j < n; j++ {
            if grid[i][j] > maxRow {
                maxRow = grid[i][j]
            }
        }
        xz += maxRow
    }
    for j := 0; j < n; j++ {
        maxCol := 0
        for i := 0; i < n; i++ {
            if grid[i][j] > maxCol {
                maxCol = grid[i][j]
            }
        }
        yz += maxCol
    }
    return xy + xz + yz
}