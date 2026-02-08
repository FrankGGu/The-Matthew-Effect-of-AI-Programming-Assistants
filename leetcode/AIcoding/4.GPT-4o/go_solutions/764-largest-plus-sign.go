func orderOfLargestPlusSign(n int, mines [][]int) int {
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
        for j := range dp[i] {
            dp[i][j] = 1
        }
    }
    for _, mine := range mines {
        dp[mine[0]][mine[1]] = 0
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if dp[i][j] == 1 {
                if i > 0 {
                    dp[i][j] += dp[i-1][j]
                }
                if j > 0 {
                    dp[i][j] += dp[i][j-1]
                }
            }
        }
    }

    maxOrder := 0
    for i := n - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if dp[i][j] > 0 {
                order := dp[i][j]
                for k := 1; k < order; k++ {
                    if i+k < n && j+k < n && dp[i+k][j] > k && dp[i][j+k] > k {
                        order++
                    } else {
                        break
                    }
                }
                maxOrder = max(maxOrder, order)
            }
        }
    }
    return maxOrder
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}