func longestSpecialPath(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    directions := [][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}

    var dfs func(x, y int, visited [][]bool) int
    dfs = func(x, y int, visited [][]bool) int {
        visited[x][y] = true
        maxLength := 0

        for _, d := range directions {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny] && grid[nx][ny] > grid[x][y] {
                maxLength = max(maxLength, dfs(nx, ny, visited))
            }
        }

        visited[x][y] = false
        return maxLength + 1
    }

    maxPath := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            visited := make([][]bool, m)
            for k := range visited {
                visited[k] = make([]bool, n)
            }
            maxPath = max(maxPath, dfs(i, j, visited))
        }
    }

    return maxPath
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}