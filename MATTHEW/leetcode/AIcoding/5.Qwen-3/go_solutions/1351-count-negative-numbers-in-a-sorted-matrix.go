package main

func countNegatives(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    count := 0
    for r := 0; r < rows; r++ {
        for c := cols - 1; c >= 0; c-- {
            if grid[r][c] < 0 {
                count++
            } else {
                break
            }
        }
    }
    return count
}