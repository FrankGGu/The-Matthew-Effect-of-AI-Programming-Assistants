package main

func maxGridHappiness(n int, m int, k int) int {
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, m)
    }
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if i == 0 && j == 0 {
                dp[i][j] = 0
            } else {
                maxVal := 0
                if i > 0 {
                    maxVal = max(maxVal, dp[i-1][j])
                }
                if j > 0 {
                    maxVal = max(maxVal, dp[i][j-1])
                }
                dp[i][j] = maxVal + 1
            }
        }
    }
    return dp[n-1][m-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}