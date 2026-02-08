func minCost(paints [][]int, m int, n int, target int) int {
    const inf = int(1e9)
    dp := make([][]int, target+1)
    for i := 0; i <= target; i++ {
        dp[i] = make([]int, n+1)
        for j := 0; j <= n; j++ {
            dp[i][j] = inf
        }
    }
    dp[0][0] = 0

    for i := 1; i <= m; i++ {
        for j := target; j >= 0; j-- {
            for k := 1; k <= n; k++ {
                if dp[j][k] < inf {
                    for l := 1; l <= n; l++ {
                        if l != k {
                            dp[j][l] = min(dp[j][l], dp[j][k]+paints[i-1][l-1])
                        }
                    }
                }
            }
            if j > 0 {
                for k := 1; k <= n; k++ {
                    dp[j][k] = min(dp[j][k], dp[j-1][k]+paints[i-1][k-1])
                }
            }
        }
    }

    res := inf
    for i := 1; i <= n; i++ {
        res = min(res, dp[target][i])
    }
    if res == inf {
        return -1
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}