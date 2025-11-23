func maxScore(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    maxScore := -1 << 31

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if i == m - 1 && j == n - 1 {
                dp[i][j] = grid[i][j]
                continue
            }

            maxNext := -1 << 31
            if i + 1 < m {
                maxNext = max(maxNext, dp[i+1][j])
            }
            if j + 1 < n {
                maxNext = max(maxNext, dp[i][j+1])
            }

            dp[i][j] = grid[i][j] + maxNext
            if i != 0 || j != 0 {
                maxScore = max(maxScore, maxNext - grid[i][j])
            }
        }
    }

    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}