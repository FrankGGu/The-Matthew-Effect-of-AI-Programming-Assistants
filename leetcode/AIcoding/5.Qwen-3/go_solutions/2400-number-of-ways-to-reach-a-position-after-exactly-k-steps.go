package main

func numWays(pos int, k int) int {
    mod := 1000000007
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, pos+2)
    }
    dp[0][pos] = 1
    for step := 1; step <= k; step++ {
        for p := 0; p <= pos; p++ {
            if p-1 >= 0 {
                dp[step][p] += dp[step-1][p-1]
                dp[step][p] %= mod
            }
            if p+1 <= pos {
                dp[step][p] += dp[step-1][p+1]
                dp[step][p] %= mod
            }
        }
    }
    return dp[k][pos]
}