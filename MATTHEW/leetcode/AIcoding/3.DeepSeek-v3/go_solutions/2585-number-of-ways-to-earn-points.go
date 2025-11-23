func waysToReachTarget(target int, types [][]int) int {
    const mod = 1e9 + 7
    dp := make([]int, target+1)
    dp[0] = 1
    for _, t := range types {
        count, marks := t[0], t[1]
        for i := target; i >= 0; i-- {
            for k := 1; k <= count && i - k*marks >= 0; k++ {
                dp[i] = (dp[i] + dp[i - k*marks]) % mod
            }
        }
    }
    return dp[target]
}