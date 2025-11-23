func maxMoney(coins []int) int {
    n := len(coins)
    if n == 0 {
        return 0
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := n - 1; i >= 0; i-- {
        for j := i; j < n; j++ {
            if i == j {
                dp[i][j] = coins[i]
            } else if j == i+1 {
                dp[i][j] = max(coins[i], coins[j])
            } else {
                left := coins[i] + min(dp[i+2][j], dp[i+1][j-1])
                right := coins[j] + min(dp[i+1][j-1], dp[i][j-2])
                dp[i][j] = max(left, right)
            }
        }
    }
    return dp[0][n-1]
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