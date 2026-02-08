func countSubIslands(grid1 [][]int, grid2 [][]int) int {
    rows, cols := len(grid1), len(grid1[0])
    directions := []struct{ x, y int }{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

    var dfs func(x, y int) bool
    dfs = func(x, y int) bool {
        if x < 0 || x >= rows || y < 0 || y >= cols || grid2[x][y] == 0 {
            return true
        }
        grid2[x][y] = 0
        isSubIsland := grid1[x][y] == 1
        for _, d := range directions {
            if !dfs(x+d.x, y+d.y) {
                isSubIsland = false
            }
        }
        return isSubIsland
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid2[i][j] == 1 && dfs(i, j) {
                count++
            }
        }
    }

    return count
}