package main

func isPossible(grid [][]int) bool {
    rows := len(grid)
    cols := len(grid[0])

    sum := 0
    for _, row := range grid {
        for _, val := range row {
            sum += val
        }
    }

    if sum%2 != 0 {
        return false
    }

    target := sum / 2

    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(i, j int, current int) bool
    dfs = func(i, j int, current int) bool {
        if i < 0 || i >= rows || j < 0 || j >= cols || visited[i][j] {
            return false
        }

        current += grid[i][j]
        if current == target {
            return true
        }

        if current > target {
            return false
        }

        visited[i][j] = true
        if dfs(i+1, j, current) || dfs(i-1, j, current) || dfs(i, j+1, current) || dfs(i, j-1, current) {
            return true
        }
        visited[i][j] = false

        return false
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if dfs(i, j, 0) {
                return true
            }
        }
    }

    return false
}