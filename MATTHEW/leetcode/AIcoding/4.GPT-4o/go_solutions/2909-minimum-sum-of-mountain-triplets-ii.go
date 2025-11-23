func minimumSum(triplets [][]int) int {
    n := len(triplets)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = triplets[i][0]
    }

    for j := 1; j < n; j++ {
        dp[j] = min(dp[j], triplets[j][0])
        for i := 0; i < j; i++ {
            dp[j] = min(dp[j], dp[i]+triplets[j][0])
        }
    }

    res := dp[n-1]
    for j := n - 2; j >= 0; j-- {
        dp[j] = min(dp[j], triplets[j][1])
        for i := n - 1; i > j; i-- {
            dp[j] = min(dp[j], dp[i]+triplets[j][1])
        }
        res = min(res, dp[j])
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}