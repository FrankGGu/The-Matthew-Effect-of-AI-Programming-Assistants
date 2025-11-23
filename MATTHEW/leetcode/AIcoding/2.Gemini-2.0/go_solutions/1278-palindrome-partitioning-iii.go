func palindromePartition(s string, k int) int {
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = 1000
        }
    }
    dp[0][0] = 0

    cost := make([][]int, n)
    for i := 0; i < n; i++ {
        cost[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            l, r := i, j
            for l < r {
                if s[l] != s[r] {
                    cost[i][j]++
                }
                l++
                r--
            }
        }
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= min(i, k); j++ {
            for x := 1; x <= i; x++ {
                dp[i][j] = min(dp[i][j], dp[i-x][j-1]+cost[i-x][i-1])
            }
        }
    }

    return dp[n][k]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}