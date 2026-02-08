func numberOfWays(n int, x int) int {
    mod := 1000000007
    dp := make([]int, n+1)
    dp[0] = 1
    for a := 1; pow(a, x) <= n; a++ {
        v := pow(a, x)
        for i := n; i >= v; i-- {
            dp[i] = (dp[i] + dp[i-v]) % mod
        }
    }
    return dp[n]
}

func pow(a, x int) int {
    res := 1
    for i := 0; i < x; i++ {
        res *= a
    }
    return res
}