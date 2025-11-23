func containsCycle(grid [][]byte) bool {
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if !visited[i][j] {
                if dfs(grid, visited, i, j, -1, -1, grid[i][j]) {
                    return true
                }
            }
        }
    }
    return false
}

func dfs(grid [][]byte, visited [][]bool, i, j, pi, pj int, target byte) bool {
    if i < 0 || i >= len(grid) || j < 0 || j >= len(grid[0]) || grid[i][j] != target {
        return false
    }
    if visited[i][j] {
        return true
    }
    visited[i][j] = true

    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    for _, dir := range dirs {
        ni, nj := i + dir[0], j + dir[1]
        if ni == pi && nj == pj {
            continue
        }
        if dfs(grid, visited, ni, nj, i, j, target) {
            return true
        }
    }
    return false
}