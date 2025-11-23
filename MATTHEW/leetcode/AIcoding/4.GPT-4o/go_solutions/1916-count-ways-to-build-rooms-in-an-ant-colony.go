func countWays(n int, A []int) int {
    mod := int(1e9 + 7)
    dp := make([]int, n+1)
    dp[0] = 1
    size := 0

    for _, a := range A {
        size += a
        for j := size; j >= a; j-- {
            dp[j] = (dp[j] + dp[j-a]) % mod
        }
    }

    return dp[size]
}