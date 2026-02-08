func mergeStones(stones []int, K int) int {
    n := len(stones)
    if (n-1)%(K-1) != 0 {
        return -1
    }

    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + stones[i]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for l := K; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            dp[i][j] = math.MaxInt32
            for m := i; m < j; m += K - 1 {
                dp[i][j] = min(dp[i][j], dp[i][m]+dp[m+1][j])
            }
            if (j-i)%(K-1) == 0 {
                dp[i][j] += prefix[j+1] - prefix[i]
            }
        }
    }

    return dp[0][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}