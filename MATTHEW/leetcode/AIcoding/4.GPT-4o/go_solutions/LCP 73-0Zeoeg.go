func canReach(land [][]int, start []int) bool {
    rows, cols := len(land), len(land[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(x, y int) bool
    dfs = func(x, y int) bool {
        if x < 0 || x >= rows || y < 0 || y >= cols || visited[x][y] || land[x][y] == 0 {
            return false
        }
        if land[x][y] == 2 {
            return true
        }
        visited[x][y] = true
        return dfs(x-1, y) || dfs(x+1, y) || dfs(x, y-1) || dfs(x, y+1)
    }

    return dfs(start[0], start[1])
}