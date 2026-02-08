package main

func numberOfRightTriangles(grid [][]int) int {
    rows := make([]int, len(grid))
    cols := make([]int, len(grid[0]))

    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] == 1 {
                rows[i]++
                cols[j]++
            }
        }
    }

    result := 0

    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] == 1 {
                result += (rows[i] - 1) * (cols[j] - 1)
            }
        }
    }

    return result
}