func maxValueSum(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][][]int, m)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, k+1)
            for l := range dp[i][j] {
                dp[i][j][l] = -1 << 31
            }
        }
    }

    dp[0][0][0] = grid[0][0]
    if k > 0 {
        dp[0][0][1] = 0
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 && j == 0 {
                continue
            }
            for l := 0; l <= k; l++ {
                maxVal := -1 << 31
                if i > 0 {
                    if dp[i-1][j][l] != -1 << 31 {
                        maxVal = max(maxVal, dp[i-1][j][l] + grid[i][j])
                    }
                    if l > 0 && dp[i-1][j][l-1] != -1 << 31 {
                        maxVal = max(maxVal, dp[i-1][j][l-1])
                    }
                }
                if j > 0 {
                    if dp[i][j-1][l] != -1 << 31 {
                        maxVal = max(maxVal, dp[i][j-1][l] + grid[i][j])
                    }
                    if l > 0 && dp[i][j-1][l-1] != -1 << 31 {
                        maxVal = max(maxVal, dp[i][j-1][l-1])
                    }
                }
                dp[i][j][l] = maxVal
            }
        }
    }

    res := -1 << 31
    for l := 0; l <= k; l++ {
        res = max(res, dp[m-1][n-1][l])
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}