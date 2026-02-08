func closedIsland(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    var dfs func(int, int) bool
    dfs = func(x, y int) bool {
        if x < 0 || y < 0 || x >= rows || y >= cols {
            return false
        }
        if grid[x][y] == 1 {
            return true
        }
        grid[x][y] = 1
        isClosed := true
        for _, dir := range directions {
            if !dfs(x+dir[0], y+dir[1]) {
                isClosed = false
            }
        }
        return isClosed
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 0 && dfs(i, j) {
                count++
            }
        }
    }
    return count
}