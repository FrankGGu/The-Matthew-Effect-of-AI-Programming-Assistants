func countWays(ranges [][]int) int {
    mod := 1000000007
    n := len(ranges)

    sort.Slice(ranges, func(i, j int) bool {
        return ranges[i][0] < ranges[j][0]
    })

    dp := make([]int, n+1)
    dp[0] = 1

    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] % mod
        for j := i - 1; j >= 0; j-- {
            if j == 0 || ranges[j-1][1] < ranges[i-1][0] {
                dp[i] = (dp[i] + dp[j]) % mod
                break
            }
        }
    }

    return dp[n]
}