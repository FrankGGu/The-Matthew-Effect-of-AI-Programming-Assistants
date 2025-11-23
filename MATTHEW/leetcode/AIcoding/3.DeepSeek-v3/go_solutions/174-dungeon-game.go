func calculateMinimumHP(dungeon [][]int) int {
    m, n := len(dungeon), len(dungeon[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    dp[m-1][n-1] = max(1, 1 - dungeon[m-1][n-1])

    for i := m - 2; i >= 0; i-- {
        dp[i][n-1] = max(1, dp[i+1][n-1] - dungeon[i][n-1])
    }

    for j := n - 2; j >= 0; j-- {
        dp[m-1][j] = max(1, dp[m-1][j+1] - dungeon[m-1][j])
    }

    for i := m - 2; i >= 0; i-- {
        for j := n - 2; j >= 0; j-- {
            minHP := min(dp[i+1][j], dp[i][j+1])
            dp[i][j] = max(1, minHP - dungeon[i][j])
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

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}