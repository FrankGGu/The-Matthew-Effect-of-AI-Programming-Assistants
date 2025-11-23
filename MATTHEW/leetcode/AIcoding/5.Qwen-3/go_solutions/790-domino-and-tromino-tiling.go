package main

func numTilings(n int) int {
    MOD := 1000000007
    if n == 1 {
        return 1
    }
    if n == 2 {
        return 2
    }
    dp := make([]int, n+1)
    dp[0] = 1
    dp[1] = 1
    dp[2] = 2
    for i := 3; i <= n; i++ {
        dp[i] = (dp[i-1] + dp[i-2] + 2*sum(dp[:i-2])) % MOD
    }
    return dp[n]
}

func sum(arr []int) int {
    s := 0
    for _, v := range arr {
        s = (s + v) % 1000000007
    }
    return s
}