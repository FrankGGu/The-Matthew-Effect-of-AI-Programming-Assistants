func maxIncreaseKeepingSkyline(grid [][]int) int {
    n := len(grid)
    rowMax := make([]int, n)
    colMax := make([]int, n)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            rowMax[i] = max(rowMax[i], grid[i][j])
            colMax[j] = max(colMax[j], grid[i][j])
        }
    }

    ans := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            ans += min(rowMax[i], colMax[j]) - grid[i][j]
        }
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}