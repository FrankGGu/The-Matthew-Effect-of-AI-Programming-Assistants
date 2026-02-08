func isPossibleToCutPath(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    var dfs func(i, j int) bool
    dfs = func(i, j int) bool {
        if i == m-1 && j == n-1 {
            return true
        }
        if i >= m || j >= n || grid[i][j] == 0 || visited[i][j] {
            return false
        }
        visited[i][j] = true
        return dfs(i+1, j) || dfs(i, j+1)
    }

    if !dfs(0, 0) {
        return true
    }

    grid[0][0] = 1
    visited = make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    return !dfs(0, 0)
}