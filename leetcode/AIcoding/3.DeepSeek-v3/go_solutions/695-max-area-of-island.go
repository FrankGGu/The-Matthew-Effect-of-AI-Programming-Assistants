func maxAreaOfIsland(grid [][]int) int {
    maxArea := 0
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                area := dfs(grid, i, j, rows, cols)
                if area > maxArea {
                    maxArea = area
                }
            }
        }
    }
    return maxArea
}

func dfs(grid [][]int, i, j, rows, cols int) int {
    if i < 0 || j < 0 || i >= rows || j >= cols || grid[i][j] == 0 {
        return 0
    }
    grid[i][j] = 0
    return 1 + dfs(grid, i+1, j, rows, cols) + dfs(grid, i-1, j, rows, cols) + dfs(grid, i, j+1, rows, cols) + dfs(grid, i, j-1, rows, cols)
}