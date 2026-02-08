package main

func numberOfWays(points []int, pointsEarned []int) int {
    n := len(points)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }
    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if points[j] < points[i] && pointsEarned[j] < pointsEarned[i] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    res := 0
    for _, v := range dp {
        res = max(res, v)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}