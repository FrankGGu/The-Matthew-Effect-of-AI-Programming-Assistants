func countPartitions(n int, k int) int {
    const mod = 1_000_000_007
    if k == 0 || k > n {
        return 0
    }

    dp := make([]int, n+1)
    dp[0] = 1

    for i := 1; i <= k; i++ {
        for j := n; j >= i; j-- {
            dp[j] = (dp[j] + dp[j-i]) % mod
        }
    }

    return dp[n]
}