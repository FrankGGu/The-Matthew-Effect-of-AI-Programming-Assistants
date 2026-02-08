package main

func mergeStones(stones []int, k int) int {
    n := len(stones)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + stones[i]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for m := 2; m <= n; m++ {
        for i := 0; i <= n-m; i++ {
            j := i + m - 1
            dp[i][j] = 1 << 63
            for p := i; p < j; p++ {
                dp[i][j] = min(dp[i][j], dp[i][p]+dp[p+1][j])
            }
            if (m-1)%k == 0 {
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