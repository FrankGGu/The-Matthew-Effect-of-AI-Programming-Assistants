package main

func latestDayToCross(row int, col int, cells [][]int) int {
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    grid := make([][]int, row)
    for i := range grid {
        grid[i] = make([]int, col)
    }
    for i := 0; i < len(cells); i++ {
        grid[cells[i][0]-1][cells[i][1]-1] = i + 1
    }

    left := 0
    right := len(cells)
    ans := 0

    for left <= right {
        mid := (left + right) / 2
        visited := make([][]bool, row)
        for i := range visited {
            visited[i] = make([]bool, col)
        }
        if dfs(grid, visited, 0, 0, mid, dirs) {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return ans
}

func dfs(grid [][]int, visited [][]bool, i, j, day int, dirs [][]int) bool {
    if i < 0 || i >= len(grid) || j < 0 || j >= len(grid[0]) || visited[i][j] || grid[i][j] <= day {
        return false
    }
    if i == len(grid)-1 {
        return true
    }
    visited[i][j] = true
    for _, d := range dirs {
        ni, nj := i+d[0], j+d[1]
        if dfs(grid, visited, ni, nj, day, dirs) {
            return true
        }
    }
    return false
}