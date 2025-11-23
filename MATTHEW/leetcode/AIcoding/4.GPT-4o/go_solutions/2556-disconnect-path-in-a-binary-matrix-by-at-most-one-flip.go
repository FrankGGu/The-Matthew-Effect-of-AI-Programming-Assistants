func canDisconnect(grid [][]int) bool {
    rows, cols := len(grid), len(grid[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(int, int) bool
    dfs = func(x, y int) bool {
        if x < 0 || x >= rows || y < 0 || y >= cols || visited[x][y] || grid[x][y] == 1 {
            return false
        }
        visited[x][y] = true
        if (x == rows-1 && y == cols-1) || (x == 0 && y == 0) {
            return true
        }
        return dfs(x+1, y) || dfs(x-1, y) || dfs(x, y+1) || dfs(x, y-1)
    }

    if dfs(0, 0) {
        return false
    }

    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] == 0 {
                grid[i][j] = 1
                visited = make([][]bool, rows)
                for k := range visited {
                    visited[k] = make([]bool, cols)
                }
                if dfs(0, 0) {
                    return true
                }
                grid[i][j] = 0
            }
        }
    }
    return false
}