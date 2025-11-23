func paintWalls(cost []int, time []int) int {
    n := len(cost)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = 1 << 30
    }

    for i := 0; i < n; i++ {
        for j := n; j > 0; j-- {
            k := j - time[i] - 1
            if k < 0 {
                k = 0
            }
            if dp[k]+cost[i] < dp[j] {
                dp[j] = dp[k] + cost[i]
            }
        }
    }

    return dp[n]
}