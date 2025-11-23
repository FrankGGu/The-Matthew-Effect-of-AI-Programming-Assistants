package main

func sumOfArrayProductOfMagicalSequences(n int, m int) int {
    MOD := 1000000007
    dp := make([]int, m+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        for j := m; j >= 1; j-- {
            dp[j] = (dp[j] + dp[j-1]) % MOD
        }
    }
    return dp[m]
}