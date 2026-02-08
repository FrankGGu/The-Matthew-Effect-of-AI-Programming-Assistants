func maxScore(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxVal := make([][]int, m)
    for i := range maxVal {
        maxVal[i] = make([]int, n)
    }

    res := -1 << 31

    for i := m-1; i >= 0; i-- {
        for j := n-1; j >= 0; j-- {
            maxVal[i][j] = grid[i][j]
            if i+1 < m {
                maxVal[i][j] = max(maxVal[i][j], maxVal[i+1][j])
            }
            if j+1 < n {
                maxVal[i][j] = max(maxVal[i][j], maxVal[i][j+1])
            }
            if i+1 < m && j+1 < n {
                res = max(res, maxVal[i+1][j+1] - grid[i][j])
            }
            if i+1 < m {
                res = max(res, maxVal[i+1][j] - grid[i][j])
            }
            if j+1 < n {
                res = max(res, maxVal[i][j+1] - grid[i][j])
            }
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}