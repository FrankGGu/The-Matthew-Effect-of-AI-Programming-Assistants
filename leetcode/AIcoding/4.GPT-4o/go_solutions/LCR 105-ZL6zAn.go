func maxAreaOfIsland(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    maxArea := 0

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
            return 0
        }
        grid[r][c] = 0
        area := 1
        area += dfs(r-1, c)
        area += dfs(r+1, c)
        area += dfs(r, c-1)
        area += dfs(r, c+1)
        return area
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                maxArea = max(maxArea, dfs(r, c))
            }
        }
    }
    return maxArea
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}