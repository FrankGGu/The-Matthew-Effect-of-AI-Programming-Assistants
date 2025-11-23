func hasValidPath(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    validPaths := map[int]map[int][]int{
        1: {{0, 1}, {0, -1}},
        2: {{1, 0}, {-1, 0}},
        3: {{0, 1}, {1, 0}},
        4: {{0, -1}, {1, 0}},
        5: {{0, 1}, {-1, 0}},
        6: {{0, -1}, {-1, 0}},
    }

    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    var dfs func(x, y int) bool
    dfs = func(x, y int) bool {
        if x == m-1 && y == n-1 {
            return true
        }
        visited[x][y] = true

        for _, d := range validPaths[grid[x][y]] {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] {
                for _, pd := range validPaths[grid[nx][ny]] {
                    if pd[0] == -d[0] && pd[1] == -d[1] {
                        if dfs(nx, ny) {
                            return true
                        }
                    }
                }
            }
        }

        return false
    }

    return dfs(0, 0)
}