func minimumDamage(health []int, damage [][]int) int {
    n := len(health)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = health[i]
    }

    for _, d := range damage {
        a, b, c := d[0]-1, d[1]-1, d[2]
        dp[b] = min(dp[b], dp[a]+c)
    }

    ans := dp[0]
    for i := 1; i < n; i++ {
        ans = min(ans, dp[i])
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}