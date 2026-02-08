func palindromePartition(s string, k int) int {
    n := len(s)
    cost := make([][]int, n)
    for i := range cost {
        cost[i] = make([]int, n)
    }
    for l := 2; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            if s[i] == s[j] {
                cost[i][j] = cost[i+1][j-1]
            } else {
                cost[i][j] = cost[i+1][j-1] + 1
            }
        }
    }

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 1; j <= k; j++ {
            for m := 0; m < i; m++ {
                if dp[m][j-1] != math.MaxInt32 {
                    dp[i][j] = min(dp[i][j], dp[m][j-1]+cost[m][i-1])
                }
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