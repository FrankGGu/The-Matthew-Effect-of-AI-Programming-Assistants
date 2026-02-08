func maxAreaOfIsland(grid [][]int) int {
    maxArea := 0
    rows, cols := len(grid), len(grid[0])

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
            return 0
        }
        grid[r][c] = 0
        area := 1
        area += dfs(r+1, c)
        area += dfs(r-1, c)
        area += dfs(r, c+1)
        area += dfs(r, c-1)
        return area
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                area := dfs(r, c)
                if area > maxArea {
                    maxArea = area
                }
            }
        }
    }
    return maxArea
}