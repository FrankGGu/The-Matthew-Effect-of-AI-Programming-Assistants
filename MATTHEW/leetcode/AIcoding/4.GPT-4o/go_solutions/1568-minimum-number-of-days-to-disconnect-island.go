func minDays(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    directions := [][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}

    var dfs func(x, y int)
    dfs = func(x, y int) {
        grid[x][y] = 0
        for _, d := range directions {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && ny >= 0 && nx < rows && ny < cols && grid[nx][ny] == 1 {
                dfs(nx, ny)
            }
        }
    }

    cnt := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                cnt++
                dfs(i, j)
            }
        }
    }

    if cnt == 0 {
        return 0
    }
    if cnt == 1 {
        return 1
    }
    return 2
}