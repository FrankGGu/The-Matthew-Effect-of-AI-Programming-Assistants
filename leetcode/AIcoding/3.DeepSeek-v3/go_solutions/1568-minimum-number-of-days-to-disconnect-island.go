func minDays(grid [][]int) int {
    if isDisconnected(grid) {
        return 0
    }
    m, n := len(grid), len(grid[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                grid[i][j] = 0
                if isDisconnected(grid) {
                    return 1
                }
                grid[i][j] = 1
            }
        }
    }
    return 2
}

func isDisconnected(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 && !visited[i][j] {
                if count > 0 {
                    return true
                }
                dfs(grid, visited, i, j)
                count++
            }
        }
    }
    return count != 1
}

func dfs(grid [][]int, visited [][]bool, i, j int) {
    m, n := len(grid), len(grid[0])
    if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 || visited[i][j] {
        return
    }
    visited[i][j] = true
    dfs(grid, visited, i+1, j)
    dfs(grid, visited, i-1, j)
    dfs(grid, visited, i, j+1)
    dfs(grid, visited, i, j-1)
}