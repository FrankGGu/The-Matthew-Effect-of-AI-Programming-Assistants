func minimumTotal(triangle [][]int) int {
    n := len(triangle)
    dp := make([]int, n)
    copy(dp, triangle[n-1])

    for i := n-2; i >= 0; i-- {
        for j := 0; j <= i; j++ {
            dp[j] = triangle[i][j] + min(dp[j], dp[j+1])
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