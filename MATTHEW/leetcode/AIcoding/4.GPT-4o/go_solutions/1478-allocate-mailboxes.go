func minDistance(houses []int, k int) int {
    n := len(houses)
    sort.Ints(houses)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }

    for i := 0; i <= n; i++ {
        dp[i][0] = 0
    }

    for j := 1; j <= k; j++ {
        for i := 1; i <= n; i++ {
            for p := 0; p < i; p++ {
                dp[i][j] = min(dp[i][j], dp[p][j-1]+cost(houses[p:i]))
            }
        }
    }

    return dp[n][k]
}

func cost(houses []int) int {
    if len(houses) == 0 {
        return 0
    }
    mid := houses[len(houses)/2]
    totalCost := 0
    for _, h := range houses {
        totalCost += abs(h - mid)
    }
    return totalCost
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}