package main

func findMinimums(grid [][]int) []int {
    m, n := len(grid), len(grid[0])
    res := make([]int, m)
    for i := 0; i < m; i++ {
        res[i] = -1
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                continue
            }
            if res[i] == -1 || grid[i][j] < res[i] {
                res[i] = grid[i][j]
            }
        }
    }
    return res
}