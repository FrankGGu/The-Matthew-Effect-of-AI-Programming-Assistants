func longestSpecialPath(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    directions := [][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
    maxPath := 0

    var dfs func(x, y, prevValue int, visited [][]bool) int
    dfs = func(x, y, prevValue int, visited [][]bool) int {
        if x < 0 || x >= m || y < 0 || y >= n || visited[x][y] || grid[x][y] <= prevValue {
            return 0
        }
        visited[x][y] = true
        maxLen := 0
        for _, dir := range directions {
            nextX, nextY := x+dir[0], y+dir[1]
            maxLen = max(maxLen, dfs(nextX, nextY, grid[x][y], visited))
        }
        visited[x][y] = false
        return maxLen + 1
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            visited := make([][]bool, m)
            for k := range visited {
                visited[k] = make([]bool, n)
            }
            maxPath = max(maxPath, dfs(i, j, -1, visited))
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