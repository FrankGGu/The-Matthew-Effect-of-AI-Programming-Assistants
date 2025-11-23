func calculateMinimumHP(dungeon [][]int) int {
    m := len(dungeon)
    n := len(dungeon[0])
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = 1 << 31 - 1
    }
    dp[n-1] = 1

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if i == m-1 && j == n-1 {
                dp[j] = max(1, 1-dungeon[i][j])
            } else if i == m-1 {
                dp[j] = max(1, dp[j+1]-dungeon[i][j])
            } else if j == n-1 {
                dp[j] = max(1, dp[j]-dungeon[i][j])
            } else {
                dp[j] = max(1, min(dp[j], dp[j+1])-dungeon[i][j])
            }
        }
    }
    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}