func maxEnergy(dungeon [][]int) int {
    m, n := len(dungeon), len(dungeon[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    dp[m-1][n-1] = max(1, 1-dungeon[m-1][n-1])

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if i < m-1 {
                dp[i][j] = max(dp[i][j], dp[i+1][j] - dungeon[i][j])
            }
            if j < n-1 {
                dp[i][j] = max(dp[i][j], dp[i][j+1] - dungeon[i][j])
            }
            if dp[i][j] <= 0 {
                dp[i][j] = 1
            }
        }
    }

    return dp[0][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}